# Ruby on Rails Timesheet Application

This is a timesheet application built by Jennifer Ralph. For specifications such as validations and timesheet calculations, please see "Timesheet_app_specifications.pdf"

## Assumptions

It is assumed that each timesheet entry occurs in a single day, i.e. the user does not have a shift that runs over midnight.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```