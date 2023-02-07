//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract crowdfunding{
   address public admin;
    uint public target;
    uint public endtime;
    mapping(address=>uint) public contributors;
    uint public raisedamount;
    struct request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noofvoters;
        mapping(address=>bool) voters;
    }
    mapping(uint=> request) public requests;

    uint public numrequests;
    uint public a;

    
    constructor(){
        admin=payable(msg.sender);
         endtime=block.timestamp+403200;
        target =25 ether;
    }

    event Contributeevent(address _sender,uint _value);
    event Createrequestevent(string _description,address _recipient,uint _value);
    event Makepaymentevent(address _recipient,uint _value);


    function contribute()public payable{
        require(msg.sender!=admin);
        require(block.timestamp<endtime,"Time has passed");

        contributors[msg.sender]+=msg.value;
        raisedamount=raisedamount+msg.value;
    a++;   
    emit Contributeevent(msg.sender,msg.value);

    }

   receive() external payable{
       contribute();
    }
    
   
    function getbalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public payable{
        require(contributors[msg.sender]>0 && block.timestamp>endtime);
        payable(msg.sender).transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;
    }


modifier onlyadmin(){
    require(msg.sender == admin, "");
    _;
}


    function createrequest(string memory _description, address payable _recipient,uint _value) public onlyadmin{
        request storage newrequest = requests[numrequests];
        numrequests++;

        newrequest.description=_description;
        newrequest.recipient=_recipient;
        newrequest.value=_value;
        newrequest.completed=false;
        newrequest.noofvoters=0;
        emit Createrequestevent(_description,_recipient,_value);
    }

    function voterequest(uint _requestno) public{
        require(contributors[msg.sender]>0);
        request storage thisrequest= requests[_requestno];
        require(thisrequest.voters[msg.sender]==false);
        thisrequest.voters[msg.sender]=true;
        thisrequest.noofvoters++;
    }


function makepayment(uint _requestno) public payable onlyadmin{
    require(raisedamount >= target);
    request storage thisrequest= requests[_requestno];
    require(thisrequest.noofvoters > a/2 && thisrequest.completed==false);
    (thisrequest.recipient).transfer(thisrequest.value);
    thisrequest.completed=true;
    emit Makepaymentevent(thisrequest.recipient,thisrequest.value);
}



}
