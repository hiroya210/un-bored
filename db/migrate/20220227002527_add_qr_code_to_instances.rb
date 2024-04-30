class AddQrCodeToInstances < ActiveRecord::Migration[6.0]
  def change
    add_column :instances, :qr_code, :string
  end
end
