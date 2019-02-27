
zsearch
=======

About
-----

Search through JSON files for user, organization, and ticket data


Use
---

```
bin/zsearch
```

Follow the prompts:

```
Welcome to Zendesk Search
Type 'quit' to exit at any time


	Select search options:
	 * Press 1 to search Zendesk
	 * Press 2 to view a list of searchable fields
	 * Type 'quit' to exit

 1
Select 1) Users or 2) Tickets or 3) Organizations
 1
Enter search term  _id
Enter search value  1
_id                  1
url                  http://initech.zendesk.com/api/v2/users/1.json
external_id          74341f74-9c79-49d5-9611-87ef9b6eb75f
name                 Francisca Rasmussen
alias                Miss Coffey
created_at           2016-04-15T05:19:46 -10:00
active               true
verified             true
shared               false
locale               en-AU
timezone             Sri Lanka
last_login_at        2013-08-04T01:03:27 -10:00
email                coffeyrasmussen@flotonic.com
phone                8335-422-718
signature            Don't Worry Be Happy!
organization_id      119
tags                 ["Springville", "Sutton", "Hartsville/Hartley", "Diaperville"]
suspended            true
role                 admin
Organizations       Multron
Submitted Tickets   A Nuisance in Kiribati, A Nuisance in Saint Lucia
Assigned Tickets    A Problem in Russian Federation, A Problem in Malawi
```


Developing
----------

First, install bundler:

```
gem install bundler
```

Then get the dependencies:

```
bundle install
```


Author
------

Kirsten Comandich <kcomandich@gmail.com>


License
-------

This program is provided under an MIT open source license, read the [MIT-LICENSE.txt](MIT-LICENSE.txt) file for details.


Copyright
---------

Copyright (c) 2019 by Kirsten Comandich

