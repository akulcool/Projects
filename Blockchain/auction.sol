//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

contract auctioncreator{
    auction[] public auctions;
    
    function createauction() public{
        auction newauction =new auction(msg.sender);
        auctions.push(newauction);
    }

}






contract auction{
    address payable public  owner;
    uint public startblock;
    uint public endblock;
    string public ipfsHash;
    enum state{started,running,ended,canceled}
    state public auctionstate;

    uint public highestbindingbid;
    address payable public highestbidder;
    mapping(address=>uint) public bids;

    uint bidincrement;



    constructor(address eoa){
        owner= payable(eoa);
        auctionstate=state.running;
        startblock =block.number;
        endblock =startblock +403200; //1 week duration of bidding based on blocktime
        ipfsHash="";
        bidincrement=100;
    }

     modifier onlyowner(){
        require(msg.sender==owner);
        _;
    }

    
    
    modifier notowner(){
        require(msg.sender!=owner);
        _;
    }

    modifier afterstart(){
        require(block.number>=startblock);
        _;
    }
    
      modifier beforeend(){
        require(block.number<=endblock);
        _;
    }
    
    function min(uint a,uint b) pure internal returns(uint){
        if(a<=b){
            return a;
        }
        else{
            return b;
        }
    } 



    function placebid() public payable notowner afterstart beforeend
    {
        require(auctionstate == state.running);
        require(msg.value>=100);
        uint currentbid=bids[msg.sender]+msg.value;

        require(currentbid>highestbindingbid);
        bids[msg.sender]=currentbid;

        if(currentbid<=bids[highestbidder]){
            highestbindingbid=min(currentbid+bidincrement,bids[highestbidder]);
        }else{
            highestbindingbid=min(currentbid,bids[highestbidder]+bidincrement);
            highestbidder=payable(msg.sender);
        }
    
    
    }



    function cancel() public onlyowner{
        auctionstate=state.canceled;
    }

   
    
    function finalresult() public payable {
       require(bids[payable(msg.sender)]>0);
        if(auctionstate==state.ended){
            if(msg.sender!=highestbidder){
           payable(msg.sender).transfer(bids[msg.sender]);
            }
            else{
              payable(msg.sender).transfer(bids[msg.sender]-highestbindingbid);  
            }
         }
         else if(auctionstate==state.canceled){
            payable(msg.sender).transfer(bids[msg.sender]);
         }

       
    bids[payable(msg.sender)]=0;
    }

  
}
