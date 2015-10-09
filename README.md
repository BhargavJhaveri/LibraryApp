

The preconfigured admin id is vravi2@ncsu.edu and password id viswa123

To check out a book you need to search the book and checkout

The flash messages apperars if form filled is invalid or page reloads.For some flash messages might not appear now.we are working on that
-  **VALIDATIONS** 
validations are:  you need to fill all details,
                 A library member or admin all have distinct email id,
                 a book have unique isbn 
-  **Functions of admin**
Admin can edit his profile,delete other admin members other than himself,And all basic functions are implemented,He can check out book for librarymembers 

-  **Functions of librarymembers**
All basic functionalities are implemented,**he can request to notify by  email**,**he can give suggestions** 
-  **edge case**
We cannot delete a book that is checkedout.you need to check in the book and delete
,You cannot delete library member who has checked out book you need to check in his books before deleting 
- **Test**
All tests are implememted in rspec,Unit test is wriiten for library members model,Functional test is written for library member controller. 
                

