pragma solidity 0.5.1;
import "browser/Course.sol";

contract Manager {
    //Address of the school administrator
    address admin;
    
    mapping (address => int) student;
    mapping (address => bool) isStudent;
    mapping (int => bool) isCourse;
    mapping (int => Course) course;
    
    int rollCount = 19111000;
    
    //Constructor
    constructor() public{
        
        admin=msg.sender;

    }
    
    
    function kill() public{
        //The admin has the right to kill the contract at any time.
        //Take care that no one else is able to kill the 
        // msg.sender signifies the address of the contract owner currently calling the function
        
        if(admin==msg.sender){
            selfdestruct(msg.sender);
        }
        else{
            return;
        }

    }
    
    function addStudent() public{
        //Anyone on the network can become a student if not one already
        //Remember to assign the new student a unique roll number
        require(!isStudent[msg.sender],"Student alreay exists");
        student[msg.sender]=rollCount;
        rollCount++;    
        isStudent[msg.sender]=true;
            
    
    
         //   console.log(msg.sender);
           
        

    }
    
    function addCourse(int courseNo, address instructor) public{
	//Add a new course with course number as courseNo, and instructor at address instructor
        //Note that only the admin can add a new course. Also, don't create a new course if course already exists
        require(!isCourse[courseNo],"Course Already exists");
        if(admin==msg.sender){
            isCourse[courseNo]=true;
            
            course[courseNo]=new Course(courseNo,instructor,msg.sender);
           // course[courseNo]=Course payable address(cr);
           
        }
        else{
            
            return;
        }

        

    }
    
   // function getAddress(int courseNo) public view returns (address){
        
     //   Course e=course[courseNo];
      //  address g=address(e);
    //    return g;
    //}
  /*  function getAddress(int courseNo)  public view returns(address) {
        //Check the courseNo for validity
        //Should only work for valid students of that course
	//Returns a tuple (midsem, endsem, attendance)
	address payable addr3 = address(course[courseNo]); 
    return addr3;
    }*/
   
    function regCourse(int courseNo) public{
        //Register the student in the course if he is a student on roll and the courseNo is valid
        require(isCourse[courseNo],"Course is not valid");
        require(isStudent[msg.sender],"Student does not exist");
        
       Course enr=course[courseNo];
       enr.enroll(student[msg.sender]);
       
    //    Course cr=payable (address(course[courseNo]));
    
       
    //    cr.enroll(roll);
        
        
        
        
        
    
        

    }
    
    function getMyMarks(int courseNo) public view returns(int, int, int) {
        //Check the courseNo for validity
        //Should only work for valid students of that course
	//Returns a tuple (midsem, endsem, attendance)
	require(isCourse[courseNo],"Course is not valid");
	
	Course d=course[courseNo];
	require(d.isEnroll(student[msg.sender]));
	
	int a=course[courseNo].getAttendance(student[msg.sender]);
	int b=course[courseNo].getMidsemMarks(student[msg.sender]);
	int c=course[courseNo].getEndsemMarks(student[msg.sender]);
	
	
   return(a,b,c);
     

    }
    
    function getMyRollNo() public view returns(int) {
        //Utility function to help a student if he/she forgets the roll number
        //Should only work for valid students
	//Returns roll number as int
	require(isStudent[msg.sender],"msg.sender");
	int rollnum;
    rollnum=student[msg.sender];
    return rollnum;
        }

    

    
}

