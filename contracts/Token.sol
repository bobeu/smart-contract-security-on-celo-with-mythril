// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {
  constructor () ERC20("TestToken", "TEST") {
    uint initialSupply = 1000 * (10 ** 18);
    _mint(msg.sender, initialSupply);
  }
}