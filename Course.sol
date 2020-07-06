pragma solidity 0.5.1;

contract Course {
    
    address admin;
    address ManagerContract;
    address instructor;
    int courseNo;
    
    struct Marks{
        int midsem;
        int endsem;
        int attendance;
    }
    
    mapping (int => Marks) student;
    mapping (int => bool) isEnrolled;
    
    constructor(int c, address inst, address adm) public {
        
     
        courseNo=c;
        instructor=inst;
        ManagerContract=msg.sender;
        admin=adm;
        
        
    }
       
        
        

    
    function kill() public{
        //The admin has the right to kill the contract at any time.
        //Take care that no one else is able to kill the contract
        if(admin==msg.sender){
        selfdestruct(msg.sender);}
    }
    
    function enroll(int rollNo) public {
        //This function can only be called by the ManagerContract
        //Enroll a student in the course if not already registered
        require(msg.sender==ManagerContract,"This function can only be called by the ManagerContract");
        isEnrolled[rollNo]=true;
    }
    
    function markAttendance(int rollNo) public{
        //Only the instructor can mark the attendance
        //Increment the attendance variable by one
        //Make sure the student is enrolled in the course
        require(instructor==msg.sender,"Not an Instructor");
        require(isEnrolled[rollNo],"Not enrolled");
         student[rollNo].attendance++;
    }
    
    function addMidSemMarks(int rollNo, int marks) public{
        //Only the instructor can add midsem marks
        //Make sure that the student is enrolled in the course
        require(instructor==msg.sender,"Not an Instructor");
        require(isEnrolled[rollNo],"Not enrolled");
        student[rollNo].midsem=marks;

    }
    
    function addEndSemMarks(int rollNo, int marks) public{
        //Only the instructor can add endsem marks
        //Make sure that the student is enrolled in the course
         require(instructor==msg.sender,"Not an Instructor");
         require(isEnrolled[rollNo],"Not enrolled");
         student[rollNo].endsem=marks;

    }
    
    function getMidsemMarks(int rollNo) public view returns(int) {
        //Can only be called by the ManagerContract
        //return the midSem, endSem and attendance of the student
        //Make sure to check the student is enrolled
        require(msg.sender==ManagerContract,"This function can only be called by the ManagerContract");
        require(isEnrolled[rollNo],"Not enrolled");
        int b=student[rollNo].midsem;
        return(b);
    }
    
    
    function getEndsemMarks(int rollNo) public view returns(int) {
        //Can only be called by the ManagerContract
        //return the midSem, endSem and attendance of the student
        //Make sure to check the student is enrolled
        //int b=student[rollNo].midsem;
        require(msg.sender==ManagerContract,"This function can only be called by the ManagerContract");
        require(isEnrolled[rollNo],"Not enrolled");
        int c=student[rollNo].endsem;
        return(c);

    }
    
    
    function getAttendance(int rollNo) public view returns(int) {
        //Can only be called by the ManagerContract
        //return the midSem, endSem and attendance of the student
        //Make sure to check the student is enrolled
        require(msg.sender==ManagerContract,"This function can only be called by the ManagerContract");
        require(isEnrolled[rollNo],"Not enrolled");
        int a=student[rollNo].attendance;
        
        return(a);
        

    }
    
    function isEnroll(int rollNo) public view returns(bool){
        //Returns if a roll no. is enrolled in a particular course or not
        //Can be accessed by anyone
        if(isEnrolled[rollNo]==true){
            return true;
        }
        else{
            return false;
        }

    }
    
}

