// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {VerseToken} from "../src/VerseToken.sol";
import {DeployVerseToken} from "../script/DeployVerseToken.s.sol";

contract VerseTokenTest is Test {
    VerseToken public verseToken;
    DeployVerseToken public deployVerseToken;

    address Jeremiah = makeAddr("jeremiah");
    address Alice = makeAddr("Alice");

    uint256 public constant INITIAL_BALANCE = 10 ether;

    function setUp() public {
        DeployVerseToken deployer = new DeployVerseToken();
        verseToken = deployer.run();

        vm.prank(msg.sender);
        verseToken.transfer(Jeremiah, INITIAL_BALANCE);
    }

    function testJeremiahBalance() public {
        vm.prank(Jeremiah);
        vm.deal(Jeremiah, INITIAL_BALANCE);

        assertEq(verseToken.balanceOf(Jeremiah), INITIAL_BALANCE);
    }

    function testInitialSupply() public view {}

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Jeremiah approves Alice to spend tokens on his behalf
        vm.prank(Jeremiah);
        verseToken.approve(Alice, initialAllowance);
        uint256 transferAmount = 500;

        vm.prank(Alice);
        verseToken.transferFrom(Jeremiah, Alice, transferAmount);
        assertEq(verseToken.balanceOf(Alice), transferAmount);
        assertEq(verseToken.balanceOf(Jeremiah), INITIAL_BALANCE - transferAmount);
    }
}
