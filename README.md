# Welcome to Vapor Address Book
(please run ```vapor update``` to create xcode file) 
- To create an adddress:
```
http://localhost:8080/create/<First Name>/<Last Name>/<Email Address>/<Phone Number>
> Example:
http://localhost:8080/create/Wei/Huang/weihuang@uchicago.edu/312-315-7168
```

- To update an adddress:
```
http://localhost:8080/update/<ID>/<First Name>/<Last Name>/<Email Address>/<Phone Number>
> Example:
http://localhost:8080/update/2/Wei2/Huang2/weihuang@uchicago.edu/312-315-7168
```

- To delete an adddress:
```
http://localhost:8080/delete/<ID>
> Example:
http://localhost:8080/delete/2
```

- To retrieve all adddresses:
```
http://localhost:8080/retrieve
> Example:
http://localhost:8080/retrieve
```

# Web App
- Web app URL
```
https://floating-plateau-31868.herokuapp.com
```
Some additional modification was made to the deployed version with new instruciton as below.
- To create an adddress:
```
https://floating-plateau-31868.herokuapp.com/create/<First Name>,<Last Name>,<Email Address>,<Phone Number>
> Example:
https://floating-plateau-31868.herokuapp.com/create/Wei,Huang,weihuang@uchicago.edu,312-315-7168
```

- To update an adddress:
```
https://floating-plateau-31868.herokuapp.com/update/<ID>/<First Name>,<Last Name>,<Email Address>,<Phone Number>
> Example:
https://floating-plateau-31868.herokuapp.com/update/1/Wei2,Huang2,weihuang@uchicago.edu,312-315-7168
```

- To delete an adddress:
```
https://floating-plateau-31868.herokuapp.com/delete/<ID>
> Example:
https://floating-plateau-31868.herokuapp.com/delete/1
```

- To retrieve all adddresses:
```
https://floating-plateau-31868.herokuapp.com/all
> Example:
https://floating-plateau-31868.herokuapp.com/all
```
