# Paperclip Upload

Rails engine to save [paperclip](https://github.com/thoughtbot/paperclip) attachments asynchronously. For example, if you have an `User` model with `avatar` paperclip attribute, you will:

1. Create a new upload instance to hold the avatar file temporarily.
1. Create a new user passing the upload id or instance as parameter.

## Installation

Add to your Gemfile...

```ruby
gem 'paperclip_upload'
```

Run the installer:

```shell
$ rails generate paperclip_upload:install
```

Then, add an attachment, as usually do, using paperclip.

```shell
$ rails generate paperclip user avatar
```

Inside `User` model, you need to execute `has_attached_upload` instead the `has_attached_file` paperclip's method:

```ruby
class User < ActiveRecord::Base
  has_attached_upload :avatar, path: ':rails_root/tmp/users/:id/:filename'
  do_not_validate_attachment_file_type :avatar
end
```

## Usage

### Using `upload_identifier`

**First**: you need to save an upload instance.
The engine creates the `POST /uploads` endpoint to achieve this.
After perform a `POST` to `/uploads` with a `file` param, you will get this response: `{ upload: { identifier: 'a5zr1XNZ' } }`

**Second**: supposing you have an `UsersController`, you need to perform a `POST /users` to create a new user passing the upload identifier you get previously.

```ruby
class UsersController < ApplicationController
  def create
    respond_with User.create(permitted_params)
  end

  private

  def permitted_params
    params.require(:user).permit(:avatar_upload_identifier)
  end
end
```

> Notice that you need to pass to the host model (`User` on this example): **[host_model_paperclip_attribute]+_upload_identifier** sufix as you can see in `permitted_params` method.

### Using `upload`

You can do something like this:

```ruby
class UsersController < ApplicationController
  def create
    @user = User.new
    @user.avatar_upload = PaperclipUpload::Upload.create(file: params[:file])
    @user.save!
    respond_with @user
  end
end
```

> In this case the structure is: **[host_model_paperclip_attribute]+_upload** sufix.

### Base64 Encoding

If you want to save base64 encoded attachments, you can execute the `allow_encoded_file_for` method:

```ruby
class User < ActiveRecord::Base
  has_attached_upload :avatar, path: ':rails_root/tmp/users/:id/:filename'
  allow_encoded_file_for :avatar
  do_not_validate_attachment_file_type :avatar
end
```

And then...

```ruby
class UsersController < ApplicationController
  def create
    respond_with User.create(permitted_params)
  end

  private

  def permitted_params
    params.require(:user).permit(:encoded_avatar)
    # encoded_avatar param must hold the encoded file
  end
end
```

### Creating your own `UploadsController`

You can generate your own `UploadsController` if for example:

* your controllers don't inherit from the `ApplicationController`
* you want to change the default route for `UploadsController`. (Also you can map the default controller with another route in your `routes.rb`)
* you want to add extra logic to the default `UploadsController`

Running...

```shell
$ rails generate paperclip_upload:upload_controller api/uploads api/base
```

You will get in `your_app/app/controllers/api/uploads_controller.rb`

```ruby
class Api::UploadController < Api::BaseController
  self.responder = PaperclipUploadResponder
  respond_to :json

  def create
    respond_with PaperclipUpload::Upload.create(permitted_params), status: :created
  end

  private

  def permitted_params
    params.permit(:file)
  end
end
```

and the route...

```ruby
post "api/uploads", to: "api/uploads#create", defaults: { format: :json }
```

## Configuration

You can change the engine configuration from `your_app/config/initializers/paperclip_upload.rb`

#### Configuration Options:

* `hash_salt`: The upload module uses a salt string to generate an unique hash for each instance. A salt string can be defined here to replace the default and increase the module's security.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/paperclip_upload/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

paperclip_upload is maintained by [platanus](http://platan.us).

## License

Guides is © 2015 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
