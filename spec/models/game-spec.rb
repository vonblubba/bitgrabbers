require 'spec_helper'

describe Game do
  describe '#create' do
    context 'game without description' do
      it 'fails validation' do
        expect { activate_code_method }.to raise_error(Exceptions::KeyAlreadyUsed)
      end


      context "with a code_type: 'code not unique'" do
        let(:args) { ['DEA_key_non_unique', user] }
        let(:last_activation) { Activation.last }
        subject(:activate_code_method) { described_class.activate_code(*args) }

        it 'add the activable licence associated to the user licences' do
          activate_code_method
          expect(user.licences).to match_array([valid_licence_in_activation_key])
        end

        it 'creates a new Activation for the user' do
          activate_code_method
          expect(last_activation.user).to eq user
          expect(last_activation.licence).to eq valid_licence_in_activation_key
          expect(last_activation.source).to eq 'activation_key'
        end

        it 'does not add a licence associated to the user licences if this licence is not activable' do
          activate_code_method
          expect(user.licences).to_not include(expired_licence_in_activation_key)
        end

        it 'add the key to the user activation keys' do
          activate_code_method
          expect(user.activation_keys).to match_array([code_non_unique])
        end

        it 'increment the users count in the activation key found' do
          expect { activate_code_method }.to change { code_non_unique.users.count }.from(0).to(1)
        end
      end
    end

    context 'looking for a not existing activation key in the db' do
      context 'when there is a valid licence' do
        let(:source) { Source.where(name: 'activation_key').first_or_create }
        let(:licence_type_for_students) { create(:licence_type, role: user.roles.first, sources: [source]) }
        let!(:valid_licence) do
          create(:valid_licence_with_books, elisbn: isbn.downcase, licence_types: [licence_type_for_students]).tap do |l|
            l.status = true
            l.save
          end
        end
        let(:args) { ['DEA_not_existing_key', user] }

        subject(:activate_code_method) { described_class.activate_code(*args) }

        it 'activate only valid licences' do
          stub_dea_endpoints
          expect { activate_code_method }.to change { ActivationKey.count }.from(2).to(3)
        end

        it 'add the user to the licence, when activating a key with the publisher' do
          stub_dea_endpoints
          activate_code_method
          valid_licence.reload
          expect(valid_licence.users).to match_array([user])
        end

        it 'add the user to the just created ActivationKey, when activating a key with the publisher' do
          stub_dea_endpoints
          activate_code_method
          expect(ActivationKey.last.users).to match_array([user])
        end

        it 'also creates an activation per books in the licence' do
          stub_dea_endpoints
          expect { activate_code_method }.to change { Activation.count }.from(0).to(valid_licence.books.count)
        end

        it 'create activation for the correct user' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:user_id)).to match_array [user.id, user.id]
        end

        it 'create activation with the correct licence' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:licence_id)).to match_array [valid_licence.id, valid_licence.id]
        end

        it 'create activation with the correct book' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:book_id)).to match_array valid_licence.books.map(&:id)
        end

        it 'create activation with the correct source' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:source)).to match_array ['activation_key'] * valid_licence.books.count
        end
      end

      context 'when there is a valid licence and the key was pending' do
        let(:source) { Source.where(name: 'pending_activation_key').first_or_create }
        let(:licence_type_for_students) { create(:licence_type, role: user.roles.first, sources: [source]) }
        let!(:valid_licence) do
          create(:valid_licence_with_books, elisbn: isbn.upcase, licence_types: [licence_type_for_students]).tap do |l|
            l.status = true
            l.save
          end
        end
        let(:args) { ['DEA_not_existing_key', user, true] }

        subject(:activate_code_method) { described_class.activate_code(*args) }

        it 'activate only valid licences' do
          stub_dea_endpoints
          expect { activate_code_method }.to change { ActivationKey.count }.from(2).to(3)
        end

        it 'add the user to the licence, when activating a key with the publisher' do
          stub_dea_endpoints
          activate_code_method
          valid_licence.reload
          expect(valid_licence.users).to match_array([user])
        end

        it 'add the user to the just created ActivationKey, when activating a key with the publisher' do
          stub_dea_endpoints
          activate_code_method
          expect(ActivationKey.last.users).to match_array([user])
        end

        it 'also creates an activation per books in the licence' do
          stub_dea_endpoints
          expect { activate_code_method }.to change { Activation.count }.from(0).to(valid_licence.books.count)
        end

        it 'create activation for the correct user' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:user_id)).to match_array [user.id, user.id]
        end

        it 'create activation with the correct licence' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:licence_id)).to match_array [valid_licence.id, valid_licence.id]
        end

        it 'create activation with the correct book' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:book_id)).to match_array valid_licence.books.map(&:id)
        end

        it 'create activation with the correct source' do
          stub_dea_endpoints
          activate_code_method
          expect(Activation.pluck(:source)).to match_array ['pending_activation_key'] * valid_licence.books.count
        end
      end

      context 'with an invalid licence in the db' do
        let(:source) { Source.where(name: 'activation_key').first_or_create }
        let(:licence_type_for_students) { create(:licence_type, role: user.roles.first, sources: [source]) }
        let!(:invalid_licence) { create(:expired_licence, elisbn: isbn.camelcase, licence_types: [licence_type_for_students]) }
        let(:args) { ['DEA_not_existing_key', user] }

        subject(:activate_code_method) { described_class.activate_code(*args) }

        it 'does not activate invalid licences' do
          allow_any_instance_of(PublisherWs::Deagostini::Activation)
            .to receive(:activatedkey).with(not_existing_key).and_return(isbn)
          expect { activate_code_method }.to raise_error(Exceptions::ValidKeyNoLicence)
        end
      end

      context 'with a completely unknown key' do
        let(:activation_count_before) { Activation.count }
        let(:count_before) { ActivationKey.count }
        let(:args) { ['DEA_completely_unknown_key', user] }

        subject(:activate_code_method) { described_class.activate_code(*args) }

        it "raise 'key not found'" do
          stub_activatedkey_to_return_nil
          expect { activate_code_method }.to raise_error(Exceptions::KeyNotFound)
        end

        it 'does not create the ActivationKey' do
          stub_activatedkey_to_return_nil
          expect { activate_code_method }.to raise_error(Exceptions::KeyNotFound)
          expect(count_before).to eq(ActivationKey.count)
        end

        it 'does not create the Activation' do
          stub_activatedkey_to_return_nil
          expect { activate_code_method }.to raise_error(Exceptions::KeyNotFound)
          expect(activation_count_before).to eq(Activation.count)
        end
      end

      context 'when a publisher refuses the licence' do
        let(:count_before) { ActivationKey.count }
        let(:source) { Source.where(name: 'activation_key').first_or_create }
        let(:licence_type_for_students) { create(:licence_type, role: user.roles.first, sources: [source]) }
        let!(:valid_licence) do
          create(:valid_licence_with_books, elisbn: isbn.capitalize, licence_types: [licence_type_for_students]).tap do |l|
            l.status = true
            l.save
          end
        end
        let(:args) { ['DEA_refuse_this_key', user] }

        subject(:activate_code_method) { described_class.activate_code(*args) }

        it "raise 'publisher refuse licence'" do
          stub_activatebook_to_return_nil
          expect { activate_code_method }.to raise_error(Exceptions::PublisherRefuseLicence)
        end

        it 'does not create the ActivationKey' do
          stub_activatebook_to_return_nil
          expect { activate_code_method }.to raise_error(Exceptions::PublisherRefuseLicence)
          expect(count_before).to eq(ActivationKey.count)
        end
      end
    end
  end
end
