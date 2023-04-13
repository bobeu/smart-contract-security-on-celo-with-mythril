// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

interface IERC20 {
  function transfer(address to, uint256 amount) external returns(bool);
  function allowance(address owner, address to) external returns(uint256);
  function transferFrom(address from, address to, uint amount) external returns(bool);
}

contract WithdrawalFixed {
  address public supportedToken;

  mapping (address => uint256) public tokenBalances;
  mapping (address => uint256) public balances;

  constructor (address _supportedToken) {
    supportedToken = _supportedToken;
  }

  function withdrawCelo() public {
    uint _balance = balances[msg.sender];
    if(_balance > 0) {
      balances[msg.sender] -= _balance;
      (bool done,) = address(msg.sender).call{value: _balance}("");
     require(done);
    }
  }

  function depositToken() public {
    uint allowance = IERC20(supportedToken).allowance(msg.sender, address(this));
    require(allowance > 0);
    tokenBalances[msg.sender] += allowance;
    bool done = IERC20(supportedToken).transferFrom(msg.sender, address(this), allowance);
    require(done);
  }

  function depositCelo() payable public {
    balances[msg.sender] += msg.value;
  }

  function withdrawToken() public {
    require(supportedToken != address(0), "Token is zero address");
    uint tBalance = tokenBalances[msg.sender];
    require(tBalance > 0, "No balance to withdraw");
    tokenBalances[msg.sender] -= tBalance;
    bool done = IERC20(supportedToken).transfer(msg.sender, tBalance);
    require(done);
  }
}
