// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StakeContract.sol";
import "../src/mock/ERC20Mock.sol";

contract StakeContractTest is Test {
    StakeContract public stakeContract;
    ERC20Mock public _token;
    uint256 public constant AMOUNT = 1;

    function setUp() public {
        stakeContract = new StakeContract();
        _token = new ERC20Mock();

        // creando etiquetas pata las address
        vm.label(address(stakeContract), "Stake Contract");
        vm.label(address(_token), "Mock Token");
    }

    // Normal test in foundry
    function testStake() public {
        _token.approve(address(stakeContract), AMOUNT);
        bool success = stakeContract.stake(AMOUNT, address(_token));
        assertEq(success, true);
    }

    // Fuzzing test
    function testFuzzingStake(uint16 amount) public {
        _token.approve(address(stakeContract), amount);
        bool success = stakeContract.stake(amount, address(_token));
        assertEq(success, true);
    }
}
