//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract OleanjiToken is ERC20("OleanjiToken" , "Oleanji") {

   
   
    address owner;
    struct Transaction {
        uint256 transactId;
        address sender;
        address to;
        uint256 value;
        string message;
    }
    mapping(uint256 => Transaction ) private idTransaction;
    uint256 numofTransaction;



    constructor(uint totalSupply)  {
       
       uint amount = totalSupply * 10 ** 18;
  
        owner = msg.sender;
       _mint(owner, amount);
    }



    function CreateTransactionList (address _to ,string memory _message,uint _value) public {
        address _sender = msg.sender;
        require(_sender != _to ,"You can't be the same person as receiving and collecting");
        require(_value > 0 , "You can send 0 tokens to another person");
        numofTransaction +=1;
        idTransaction[numofTransaction] = Transaction (
            numofTransaction,
            _sender,
            _to,
            _value,
            _message
        );
    }



    function FetchAllTransactions() public view returns (Transaction [] memory){
        Transaction [] memory transaction = new Transaction [] (numofTransaction);
        uint index = 0;
        for (uint i = 0; i < numofTransaction; i++) {
            uint currentPoint = idTransaction[i+1].transactId;
            Transaction storage currentTransact = idTransaction[currentPoint];
            transaction[index] = currentTransact;
            index +=1;
        }
        return transaction;

    }
 
}