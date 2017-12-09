pragma solidity ^0.4.12;

import "./StandardToken.sol";

contract RealFundToken is StandardToken {

  string constant public name = "REAL FUND Token";
  string constant public symbol = "REF";
  uint8 constant public decimals = 8;
  uint constant multiplier = 10 ** uint(decimals);

  event Deployed(uint indexed _totalSupply);
  event Burnt(address indexed _receiver, uint indexed _num, uint indexed _totalSupply);

  function RealFundToken(address walletAddress) public {
    require(walletAddress != 0x0);

    totalSupply = 5000000000000000;
    balances[walletAddress] = totalSupply;
    Transfer(0x0, walletAddress, totalSupply);
  }

  function burn(uint num) public {
        require(num > 0);
        require(balances[msg.sender] >= num);
        require(totalSupply >= num);

        uint preBalance = balances[msg.sender];

        balances[msg.sender] -= num;
        totalSupply -= num;
        Burnt(msg.sender, num, totalSupply);
        Transfer(msg.sender, 0x0, num);

        assert(balances[msg.sender] == preBalance - num);
    }
}