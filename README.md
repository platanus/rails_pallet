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
$ rake db:migrate
```

Then, add an attachment, as usually do, using paperclip.

```shell
$ rails generate paperclip user avatar
$ rake db:migrate
```

Inside `User` model, you need to execute `has_attached_upload` instead the `has_attached_file` paperclip's method:

```ruby
class User < ActiveRecord::Base
  has_attached_upload :avatar, path: ':rails_root/tmp/users/:id/:filename'
  do_not_validate_attachment_file_type :avatar
end
```

## Usage

### Using `upload_id`

**First**: you need to save an upload instance.
The engine creates the `POST /uploads` endpoint to achieve this.
After perform a `POST` to `/uploads` with a `file` param, you will get this response: `{ upload: { id: 1 } }`

> Also, you can build your own endpoint to create new uploads. You will need to perform `PaperclipUpload::Upload.create(file: params[:file])` inside your controller action.

**Second**: supposing you have your `UsersController`, you need to perform a `POST /users` to create a new user passing the upload id:

```ruby
class UsersController < ApplicationController
  def create
    respond_with User.create(permitted_params)
  end

  private

  def permitted_params
    params.require(:user).permit(:upload_id)
  end
end
```

### Using `upload`

You can do something like this:

```ruby
class UsersController < ApplicationController
  def create
    @user = User.new
    @user.upload = PaperclipUpload.find(params[:upload_id])
    @user.save!
    respond_with @user
  end
end
```

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/punto_pagos_rails/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

punto_pagos_rails is maintained by [platanus](http://platan.us).

## License

Guides is © 2014 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
