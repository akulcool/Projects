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

 function transfer(address to,uint tokens) public override returns (bool success){
     
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

    function transferfrom(address from,address to,uint tokens) public override returns(bool){
        require(balances[from]>= tokens);
        require(allowed[from][msg.sender]>=tokens);
        balances[to]+=tokens;
        balances[from]-=tokens;
         allowed[from][msg.sender] -= tokens;

    return true;
    }


   

}
