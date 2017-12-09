pragma solidity ^0.4.11;

import "./RealFundToken.sol";

contract PreSale {
    RealFundToken public token;
    address public walletAddress;
    
    uint public amountRaised;
    
    uint public bonus;
    uint public price;    
    uint public minSaleAmount;

    function PreSale(RealFundToken _token, address _walletAddress) public {
        token = RealFundToken(_token);
        walletAddress = _walletAddress;
        bonus = 25;
        price = 200000000;
        minSaleAmount = 100000000;
    }

    function () public payable {
        uint amount = msg.value;
        uint tokenAmount = amount / price;
        require(tokenAmount >= minSaleAmount);
        amountRaised += amount;
        token.transfer(msg.sender, tokenAmount * (100 + bonus) / 100);
    }

    function TransferETH(address _to, uint _amount) public {
        require(msg.sender == walletAddress);
        _to.transfer(_amount);
    }

    function TransferTokens(address _to, uint _amount) public {
        require(msg.sender == walletAddress);
        token.transfer(_to, _amount);
    }

    function ChangeBonus(uint _bonus) public {
        require(msg.sender == walletAddress);
        bonus = _bonus;
    }
    
    function ChangePrice(uint _price) public {
        require(msg.sender == walletAddress);
        price = _price;
    }
    
    function ChangeMinSaleAmount(uint _minSaleAmount) public {
        require(msg.sender == walletAddress);
        minSaleAmount = _minSaleAmount;
    }
}
