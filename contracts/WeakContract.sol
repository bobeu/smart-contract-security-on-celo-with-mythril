// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

interface IERC20 {
  function transfer(address to, uint256 amount) external returns(bool);
  function allowance(address owner, address to) external returns(uint256);
  function transferFrom(address from, address to, uint amount) external returns(bool);
}

contract WeakContract {

  mapping (address => uint256) public tokenBalances;
  mapping (address => uint256) public balances;

  function withdraw() public {
    uint _balance = balances[msg.sender];
    (bool done,) = address(msg.sender).call{value: _balance}("");
    require(done);
    balances[msg.sender] -= _balance;
  }

  function depositToken(IERC20 token) public {
    uint allowance = IERC20(token).allowance(msg.sender, address(this));
    IERC20(token).transferFrom(msg.sender, address(this), allowance);
    tokenBalances[msg.sender] += allowance;
  }

  function depositCelo() payable public {
    balances[msg.sender] += msg.value;
  }

  function withdrawToken(address _token) public {
    require(_token != address(0), "Token is zero address");
    uint tBalance = tokenBalances[msg.sender];
    if(tBalance > 0) {
      IERC20(_token).transfer(msg.sender, tBalance);
      tokenBalances[msg.sender] -= tBalance;
    }
  }
}
