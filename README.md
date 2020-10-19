# Participa Rubí

Citizen Participation and Open Government application.

This is the open-source repository for decidim_rubi, based on [Decidim](https://github.com/decidim/decidim).

## Getting started

`bin/setup`

## Setting up the application

You will need to do some steps before having the app working properly once you've deployed it:

1.  Open a Rails console in the server: `bundle exec rails console`
2.  Create a System Admin user:

```ruby
user = Decidim::System::Admin.new(email: <email>, password: <password>, password_confirmation: <password>)
user.save!
```

3.  Visit `<your app url>/system` and login with your system admin credentials
4.  Create a new organization. Check the locales you want to use for that organization, and select a default locale.
5.  Set the correct default host for the organization, otherwise the app will not work properly. Note that you need to include any subdomain you might be using.
6.  Fill the rest of the form and submit it.

There are some tasks that need to be run periodically for the platform to work:

- `decidim:metrics:all` Once a day
- `decidim:open_data:export` Once a day

You're good to go!

## Update Decidim

To update the Decidim installation on this project, first we update Gemfile
dependencies, then we call the Decidim upgrade script and then we apply
migrations (if any)

* `bundle update decidim decidim-dev`
* `bin/rails decidim:upgrade`
* `bin/rails db:migrate`

## Rubí Customization

All of these items need to be tested / adapted everytime a new update is applied.

* The Decidim primary color has been modified
* Fixed login error texts in Spanish
* Replace all "survey" occurrences for "Questionari de participació" in the texts
* Added a custom Authorization Handler that uses the Rubí API
* Added a different error message when the DNI is not found in the custom Authorization Handler. See: `app/views/ws_authorization/_form.html.erb`
* Participatory Process screen does not longer show Process Groups. See: app/enhancers/participatory_processes_controller_enhancer.rb and config/application.rb
* Participatory Process Groups are now listed in the menu bar. See config/initializers/decidim.rb and config/application.rb.
