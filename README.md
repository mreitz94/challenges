# QED Code Challenges

Hi, welcome to the QED Investors code challenges repo. We have the [Sales Admin](https://github.com/qedinvestors/challenges/tree/master/sales_admin) challenge to begin with, and hope to add others as time goes on.

## Setup

The solution was made using Ruby on Rails and MySQL.

Ruby Version: 2.5.1
Rails Version: 5.2.2.1

To start the web server
```bash
rails s
```

In your browser, navigate to 
```bash
localhost:3000
```

Authentication was implemented using devise. You will need to register and sign in before using the application.

I have added some extra testing data, one valid, and one invalid file with 1000 rows each.
```bash
more_valid_data.csv
more_invalid_data.csv
```
