/// Using local network
const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.WebsocketProvider('ws://localhost:8545'));

/// Artifact of smart contracts 
const StakeDelegation = artifacts.require("StakeDelegation");
const StakeDelegationFactory = artifacts.require("StakeDelegationFactory");
const OneInchDelegationManager = artifacts.require("OneInchDelegationManager");
const OneInch = artifacts.require("OneInch");


/***
 * @dev - Execution COMMAND: $ truffle test ./test/test-local/StakeDelegation.test.js
 **/
contract("StakeDelegation", function(accounts) {
    /// Acccounts
    let deployer = accounts[0];
    let user1 = accounts[1];
    let user2 = accounts[2];
    let user3 = accounts[3];

    /// Global Tokenization contract instance
    let stakeDelegation;
    let stakeDelegationFactory;
    let oneInchDelegationManager;
    let oneInch;

    /// Global variable for each contract addresses
    let STAKE_DELEGATION;
    let STAKE_DELEGATION_FACTORY;
    let ONEINCH_DELEGATION_MANAGER;
    let ONEINCH;

    describe("Check state in advance", () => {
        it("Check all accounts", async () => {
            console.log('\n=== accounts ===\n', accounts, '\n========================\n');
        }); 
    }); 

    describe("Setup smart-contracts", () => {
        it("Deploy the OneInch contract instance", async () => {
            const owner = deployer;
            oneInch = await OneInch.new(owner, { from: deployer });
            ONEINCH = oneInch.address;
        });

        it("Deploy the StakeDelegationFactory contract instance", async () => {
            stakeDelegationFactory = await StakeDelegationFactory.new(ONEINCH, { from: deployer });
            STAKE_DELEGATION_FACTORY = stakeDelegationFactory.address;
        });

        it("Deploy the OneInchDelegationManager contract instance", async () => {
            oneInchDelegationManager = await OneInchDelegationManager.new(ONEINCH,{ from: deployer });
            ONEINCH_DELEGATION_MANAGER = oneInchDelegationManager.address;
        });
    });

    describe("StakeDelegationFactory", () => {
        it("a new StakeDelegation contract should be created", async () => {
            txReceipt = await stakeDelegationFactory.createNewStakeDelegation({ from: user1 });

            let events = await stakeDelegationFactory.getPastEvents('StakeDelegationCreated', {
                filter: {},  /// [Note]: If "index" is used for some event property, index number is specified
                fromBlock: 0,
                toBlock: 'latest'
            });
            console.log("\n=== Event log of StakeDelegationCreated ===", events[0].returnValues);  /// [Result]: Successful to retrieve event log
        });
    });


});
