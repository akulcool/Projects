//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;



interface ERC20Interface{
    function totalsupply() external view returns(uint);
    function balanceof(address tokenowner) external view returns (uint balance);
    function transfer(address to,uint tokens) external returns (bool success);
    

    function allowance(address tokenowner,address spender) external view returns(uint remaining);
    function approve(address spender,uint tokens) external returns(bool success);
    function transferfrom(address from,address to,uint tokens) external returns(bool success);

    event Transfer(address indexed from,address indexed to,uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

}


contract ManCitytoken is ERC20Interface{

    string public name="ManCitytoken";
    string public symbol="MCFC";
    uint public decimals=0; //18

    uint public override totalsupply;

    address public founder;
    mapping(address=>uint) public balances;
    //balances[address]=20 MCFC.

    mapping(address => mapping(address=>uint)) allowed;
    //ox111... (owner) allows 0x222... (spender) ... 100 tokens
    //allowed[ox111...][ox222....]=100


    constructor(){
        totalsupply=1000000;
        founder=msg.sender;
        balances[founder]=totalsupply;
    }

    function balanceof(address tokenowner) public view override returns (uint balance){
        return balances[tokenowner];
    }

 function transfer(address to,uint tokens) public virtual override returns (bool success){
     
     require(balances[msg.sender]>=tokens);
       balances[to]+=tokens;
       balances[msg.sender]-=tokens;
        emit Transfer(msg.sender,to,tokens);
        return true;
 }

function allowance(address tokenowner,address spender) view public override returns(uint){
    return allowed[tokenowner][spender];
}

 function approve(address spender,uint tokens) public override returns(bool){
     require(balances[msg.sender]>= tokens);
     require(tokens > 0);
     allowed[msg.sender][spender]=tokens;


    emit Approval(msg.sender,spender,tokens);
     return true;
 }

    function transferfrom(address from,address to,uint tokens) public virtual override returns(bool){
        require(balances[from]>= tokens);
        require(allowed[from][msg.sender]>=tokens);
        balances[to]+=tokens;
        balances[from]-=tokens;
         allowed[from][msg.sender] -= tokens;

    return true;
    }


   

}



contract ICO is ManCitytoken{
    address public admin;
    address payable public deposit;
    uint public hardcap=300 ether;
    uint public tokenprice=0.001 ether;
    uint public raisedamount;
    enum stages{beforestart,running,afterend,halted}
   uint public mininvestment=0.01 ether;
   uint public maxinvestment=5 ether; 
   uint public starttime=block.timestamp;
   uint public endtime=block.timestamp+604800;  //ico ends in a week
   uint public tradestart= endtime+604800;
   stages public icostage;


   constructor(address payable _deposit){
       deposit= _deposit;
       admin=msg.sender;
       icostage=stages.beforestart;
   } 

   function emergencystop() public{
       require(msg.sender==admin);
        icostage=stages.halted;
   }
   
   function restart() public{
       require(msg.sender==admin);
        icostage=stages.running;
        starttime=block.timestamp;
        endtime=block.timestamp + 604800;
   }

   function changedepositaddress(address payable newdeposit) public{
       require(msg.sender==admin);
       deposit=newdeposit;
   }

   function returnstate() public view returns(stages){
       if(block.timestamp <= starttime){
           return stages.beforestart;
       }else if(block.timestamp > starttime && block.timestamp < endtime){
           return stages.running;
       }else if(block.timestamp > endtime){
           return stages.afterend;
       }
}

    event Invest(address investor,uint value,uint tokens);

    function invest() payable public returns(bool){
        require(returnstate()==stages.running);
        require(msg.value>=mininvestment && msg.value<=maxinvestment);
        raisedamount+=msg.value;
        require(raisedamount<=hardcap);
        uint tokens = msg.value/tokenprice;

        balances[msg.sender]+=tokens;
        balances[founder]-=tokens;
        deposit.transfer(msg.value);
        emit Invest(msg.sender,msg.value,tokens);
    
    return true;
    
    }

    receive() payable external{
        invest();
    }

    function transfer(address to,uint tokens) public override returns (bool success){
        require(block.timestamp > tradestart);
        ManCitytoken.transfer(to,tokens);
        return true;
    }

     function transferfrom(address from,address to,uint tokens) public virtual override returns(bool){
         require(block.timestamp > tradestart);
        ManCitytoken.transferfrom(from,to,tokens);
        return true;

     }

     function burn() public returns(bool){
         require(returnstate()==stages.afterend);
         balances[founder]=0;
         return true;
     }
    

}
