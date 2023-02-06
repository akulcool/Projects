//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract Lottery{

    address payable[] public players;
    address public manager;
    uint public x=0;

    constructor(){
        manager= msg.sender;
    }

    receive () external payable{
        require(msg.sender!=manager);
        require(msg.value == 0.1 ether);
        players.push(payable(msg.sender));
        x++;

    }
    
    function getbalance() public view returns(uint){
     require(msg.sender == manager);
        return address(this).balance;
    }

    function random() public view returns(uint){
      require(msg.sender==manager);
       return uint (keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function winnerindex() public view returns(uint){
       require(msg.sender==manager);
       require(x>=3);
        return random()%x;
    }

    function fundtransfer() public payable{
        require(msg.sender==manager);
         require(x>=3);
        players[winnerindex()].transfer(getbalance());
    
        players= new address payable[](0);//reset the lottery
    } 



}
