import 'dart:io';

class Book{
  String?bookTitle ; 
  String?authorName; 
  int?publicationYear; 
 
}


List<Book>infoOfBook=[] ;
Map<int,Book>dectionary={} ; 
int ?id;
 
String?categoriesEnter; 
Map<String,List<String>>categoriesMap={}; 




void add(Book addBook, int id){
infoOfBook.add(addBook); // this list enter address refer to object
 dectionary[id]=addBook ; // add to map the key have the uniqe number the user enter and value address refer to object 
      
}


void categoriesBook(String categories, String name ){ 
  if(categoriesMap.containsKey(categories)){// to be shure if the categuraise are thre on key serch for the same name 
    categoriesMap[categories]!.add(name);// add value name as list like whene identifier 
  }
  else{// if the categurise not found on the key i will add ney element on map 
    categoriesMap[categories]=[name];// add element to the map the key will be string of categorise and the value be List for the book 
  }

}



//function to delete 
void delete(int removeBook){
  int ?toDelete; //varible to store the id match the id user want to delete 
  dectionary.forEach((id,bookAddress){// for RO go in every element 
if(id==removeBook){
   toDelete=id; 
}
  });
  dectionary.remove(toDelete); //remove and delete the element when dele key the value 
 

 

}



void sort(){// function to sort the book based on publicatin year 
infoOfBook.sort((a,b)=>a.publicationYear!.compareTo(b.publicationYear!)); // compare  the first element with anouther element 
for(var b in infoOfBook){
  print("Book Title:${b.bookTitle} authorName:${b.authorName} publicationYear${b.publicationYear}  "); 
}}



void main(){
   
  bool toExit=true ; //varible i use't for the condtion of while loop 
  print("choose between 1- Arabic or 2- English\n\n enter nuber for your chose ");
  int ?lang =int.tryParse(stdin.readLineSync()!); //user input to the varible 

  //Support multiple languages 
  if(lang==1){ 
    print("اهلا بك بالمكتبة ") ;
  }else{
  print("Hi, welcome to the library") ; }


// Make sure that the user entered the correct option for the lang variable to choose the CLI language.
  if(lang!=null &&(lang>0&&lang<=2)){
/*
 continue asking the user about the operations he wants until he chooses to exit the program.
  The loop depends on the variable toExit until its value changes to false . 
 */
  do{ //enter the loop 
    //here some printing cooding for the user depend on the value for varible lang 
  if(lang==1){
    print("   "); 
    print("___________________________________________") ; 
    print(": هنا 6 عمليات يمكن القيام بها");
    print("\t1- اضافة كتاب ");
    print("\t2- عرض الكتب "); 
    print("\t3- التعديل على كتاب  ") ; 
    print("\t4- البحث عن كتاب ");
    print("\t5- حذف كتاب "); 
    print("\t6- الخروج من البرنامج ") ; 
    stdout.write("من فضلك اختر رقم العملية المراد تنفيذها  \t") ;//print on the same line 
  }else{
    print("    ") ;
    print("___________________________________________") ; 
    print("there is here 6 action : ");
    print("\t1- Adding a Book");
    print("\t2- Listing Books"); 
    print("\t3- Editing a Book ") ; 
    print("\t4- Searching for a Book");
    print("\t5- Deleting a Book"); 
    print("\t6- Exiting the Program") ; 
    stdout.write("plese choose number for the action you want to do ! \t") ; }

    String ?action=stdin.readLineSync(); //varible input user 
    int? actionN ; // varible 

    // if the user enters letters or null i throw exception i use parse 
    try{
     actionN=int.parse(action!); 
    }catch(e){
      if(lang==1){
      print("\n من فضلك ادخل رقم فقط  \t$e");
      }else{
      print("\n please entere only number \t$e"); }
    }
     



     /* Check that the user entered the number. 
        If the entered number is equal to 1,
        he chose this number based on the list that appeared to him,
        and the number 1 adding a book
     */ 
    if(actionN==1){
      Book book = Book(); //create object (Every time I add a book, the book is an object of a class whose name Book contains variables.)
     
     //here some printing and input cooding for the user depend on the value for varible lang 
      if(lang==1){
        stdout.write(" معرف: ");  
        try{
      id=int.parse(stdin.readLineSync()!);//the id for the book enter by the user 
        }catch(e){
           print("id accept only number\t ");
        }
        stdout.write(" عنوان الكتاب : "); 
      book.bookTitle=stdin.readLineSync();//book pointer to class have three varible user input valuse here for bookTitle 
      stdout.write(" اسم الؤلف : "); 
      book.authorName=stdin.readLineSync(); 
      stdout.write(" سنة النشر: ") ; 
      book.publicationYear=int.tryParse(stdin.readLineSync()!) ; 
      stdout.write(" الفئة : ") ;
      categoriesEnter=stdin.readLineSync();
      }else{
      stdout.write(" Id: "); 
      try{
      id=int.parse(stdin.readLineSync()!);//the id for the book enter by the user 
        }catch(e){
           print("id accept only number\t ");
        } //the id for the book enter by the user 
      stdout.write(" Book Title: "); 
      book.bookTitle=stdin.readLineSync();
      stdout.write(" Author Name: "); 
      book.authorName=stdin.readLineSync(); 
      stdout.write(" Publication Year: ") ; 
      book.publicationYear=int.tryParse(stdin.readLineSync()!) ; 
      stdout.write(" categories : ") ;
      categoriesEnter=stdin.readLineSync()!;
      }

      bool test=false ; 
      for(int i = 0 ; i<infoOfBook.length;i++){// use for loop to compare each element with new book add if thre is same  
            Book pointer=infoOfBook[i]; // varible to point the object to make me compare 
            // there is duplicate if the author name of new book equals author name on the list (object(varible)) remove space put allofthem lowercase
            if((pointer.authorName!.trim().toLowerCase() ==book.authorName!.trim().toLowerCase() )&&( pointer.bookTitle!.trim().toLowerCase()==book.bookTitle!.trim().toLowerCase())){
              test=true; 
              break; // exit the loop 
      }}

      if(test){//After making sure that the book is already registered and the value of the variable has changed, print me a message saying that the book is present
        if(lang==1){
           print(" \n !هذا الكتاب موجود مسبقا ");
        }else{
           print("\n  this book is alrady here ! ");}
           
      }
      else{
      /*
        A function that does not return anything, add book and information for it 
        a function arrgument takes two values The first value takes the address that refers to the object
        that i created and entered the values ​​of the variables into,
        and the second value takes the identifier.
      */
      add(book,id!); 
      String ?b = book.bookTitle; // varible take the name of book 
      /*
        A function that does not return anything, 
         it's just arrang put books of the same category together 
         function takes two values The first value takes name of catagores of this book add 
         the another the name of book */

      categoriesBook(categoriesEnter!,b! );

      if(lang==1){
       print ("تمت الاضافة بنجاح ") ;
      }else{
        print ("add is done sucssufly ") ;// aproov massege 
      }
      }
      }

     /* Check that the user entered the number. 
        if the entered number is equal to 2,
        he chose this number based on the list that appeared to him,
        and the number 2 listing the book on the libray 
     */ 
    else if(actionN==2){
      if(dectionary.isEmpty){// make sure for the map or the library if it's empty the massege will appere 
        if(lang==1){
        print("\t المكتبة فاضية ") ;
        }else{
        print("\t the library is empty ") ; }
      }else{// if there is element on map it's not empty go over each item and print value , value here is address refer to object 
        dectionary.forEach((id,bookaddress)
        {print("\nid: $id\nBooktitle:${bookaddress.bookTitle}\nAuthor Name:${bookaddress.authorName}\n Publication Year:${bookaddress.publicationYear}\n  categoriesr:");});
      }
    }


  /* Check that the user entered the number. 
        if the entered number is equal to 3,
        he chose this number based on the list that appeared to him,
        and the number 3 editing the book  
     */ 
    else if(actionN==3){
      print(" "); 
      if(lang==1){
        stdout.write("\n :من فضلك ماالكتاب الذي تريد تعديله! من فضلك اختر رقم المعرف بالكتاب  ");
      }else{
      stdout.write("\n which book you want to edit! please chose the id of book  = "); }
      int ?idToEdit =int.tryParse(stdin.readLineSync()!); // user chose the book he want to edit 
      
      if(idToEdit!=null&&dectionary.containsKey(idToEdit)){//if varible the user input not null and on the map key serch for the id he entere if it's here  
      dectionary.forEach((id,bookAddress){// loop on evere element on map take key and value 
        if(id==idToEdit){//if user input id equal the element loop stop on it 
        String ?nameOfBook =bookAddress.bookTitle; 
          if(lang==1){
          print("يمكنك التعديل الأن  ") ; 
          stdout.write("عنوان الكتاب: "); 
          bookAddress.bookTitle=stdin.readLineSync()!;//edit now on object baseid on address 
          stdout.write("\n اسم المؤلف: "); 
          bookAddress.authorName=stdin.readLineSync()!;
          stdout.write("\n سنة النشر: ");
          bookAddress.publicationYear=int.tryParse(stdin.readLineSync()!); 
          stdout.write("\n الفئة: ");
          categoriesMap.forEach((a,b){// i use forEach becuse i want to delete the book name from the catagures i but before first chech for every element
            for(int i = 0 ; i<b.length;i++){ // for to go inside the list to check 
              if(b[i]==nameOfBook){//if the name of book on the list equals the name of the book gor the user want to change 
                b.remove(nameOfBook); //delete the book 
              }
            }
          });
          categoriesEnter=stdin.readLineSync()!;//enter new catagures 
          String ?b=bookAddress.bookTitle; 
          categoriesBook(categoriesEnter!,b!);  // call the function to enter the catugeries as key and name of book  
           }
          else{
          print("you can edit now: ") ; 
          stdout.write("Booktitle:"); 
          bookAddress.bookTitle=stdin.readLineSync()!;
          stdout.write("\n Author Name :"); 
          bookAddress.authorName=stdin.readLineSync()!;
          stdout.write("\n Publication Year:");
          bookAddress.publicationYear=int.tryParse(stdin.readLineSync()!); 
          stdout.write("\n categories:");
          categoriesMap.forEach((a,b){
            for(int i = 0 ; i<b.length;i++){
              if(b[i]==nameOfBook){
                b.remove(nameOfBook); 
              }
            }
          });
          categoriesEnter=stdin.readLineSync()!;
          String ?b=bookAddress.bookTitle; 
          categoriesBook(categoriesEnter!,b!); }}}); }}
              
      


    /*  Check that the user entered the number. 
        if the entered number is equal to 4,
        he chose this number based on the list that appeared to him,
        and the number 4 searching for the book he want by enter keyword   
     */ 

    else if (actionN==4){
      if(lang==1){
        stdout.write("ادخل علامة كعنوان الكتاب او اسم المؤلف لأجد لك الكتاب ") ;
      }else{
     stdout.write("Give me a keyword about title or auther name to found your book ") ; }
     String?keyWords=stdin.readLineSync()!; // varuble take the keword  he entered 
     if(keyWords.isNotEmpty){// if the user enter keyword i search for the book, enter the if statment 
    dectionary.forEach((id,bookAddress){//go in every element on map each element cheak the book address and author name if the same that's mean the book 
       if(( bookAddress.bookTitle!.toLowerCase().contains(keyWords.toLowerCase()))||(bookAddress.authorName!.toLowerCase().contains(keyWords.toLowerCase()) )){
             if(lang==1){
              print("تقصدين هذا الكتاب  \n "); 
              print("iD: $id عنوان الكتاب  ${bookAddress.bookTitle}\n اسم المؤلف :${bookAddress.authorName}\nسنة النشر :${bookAddress.publicationYear }\n ");
             }else{
              print("you mean this book \n "); 
              print("iD: $id Booktitle: ${bookAddress.bookTitle}\n Author Name:${bookAddress.authorName}\nPublication Year:${bookAddress.publicationYear }\n "); }
          }     });}
       else{// if user dont't enter keyword 
        if(lang==1){
         print("\n عذرا لم اجد ماتريدة ");
        }else{
        print("\n sory i can't found what you whant"); }
       }}
  
     
    /*  Check that the user entered the number. 
        if the entered number is equal to 5,
        he chose this number based on the list that appeared to him,
        and the number 5 deletin book by the id the user enter   
     */ 
    else if(actionN==5){
      if(lang==1){
        stdout.write("\n ادخل معرف الكتاب المراد حذفه  "); }
        else{
      stdout.write("\n enters the id of the book they want to delete "); 
        }
      int?idForDelete=int.tryParse(stdin.readLineSync()!); // varible to enter the id number by user 
      if(idForDelete!=null){//if user enter number 
        delete(idForDelete);//function take the number to delete 
        if(lang==1){
       print ("تمت الحذف بنجاح ") ;
      }else{
        print ("delete is done sucssufly ") ;
      }
      }
    
    }





    else if(actionN==6){
      if(lang==1){
     print("خروج");
      }else{
      print("Exit"); }
      toExit=false; 
    }



    else{// if the user input dosen't match the actionN print what is inside{}
      if(lang==1){
      print("من فضلك ادخل رقم من 1 الى 6  ");
      }else{
      print("please chose number from 1 to 6 "); }
    }


  }while(toExit); // if the condition be false the loop done if not will be again ask the user about operation until he chose exit 


  stdout.write("if you want to see the catagores of book press y ");
  String?ansr=stdin.readLineSync(); 
  if(ansr!=null){
  if(ansr.trim().toLowerCase()=='y'){
    print(categoriesMap);
  }
 else{
  print("you press another character so the program will exit"); 
  return ; 
 }
  }
  

  }else{
    print("sory,but there is wrong your lang chose "); 
  }
  print("if you want to sort the book based on the publicatin year "); 
  String ?toSort; 
  try{
   toSort=stdin.readLineSync()!; 
   if(toSort.trim().toLowerCase()==true ){
    sort(); 
   }
  }catch(e){
    print(""); 
    
  }
  

  }