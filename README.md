# A liquidity protocol stake delegation contract

***
## 【Introduction of the A liquidity protocol stake delegation contract】
- This is a smart contract that ...
  - A contract should be able to vote on specific parameters in https://1inch.exchange/#/dao/governance for stake and vote delegation.
  - automatic 1inch reward distribution to stakers.

&nbsp;

***

## 【Workflow】
- 


&nbsp;

***

## 【Remarks】
- Version for following the `1inch` smart contract
  - Solidity (Solc): v0.6.12
  - Truffle: v5.1.60
  - web3.js: v1.2.9
  - openzeppelin-solidity: v3.2.0
  - ganache-cli: v6.9.1 (ganache-core: 2.10.2)


&nbsp;

***

## 【Setup】
### ① Install modules
- Install npm modules in the root directory
```
$ npm install
```

<br>

### ② Compile & migrate contracts (on local)
```
$ npm run migrate:local
```

<br>

### ③ Test (Mainnet-fork approach)
- 1: Start ganache-cli
```
$ ganache-cli
```

<br>

- 3: Execute test of the smart-contracts (on the local)
  - Test for the contract
    `$ npm run test:something`
    ($ truffle test ./test/test-local/Something.test.js)

<br>


***

## 【References】
- 1inch.exchange
  - Prize on the EtherPunk: https://1inch-exchange.medium.com/1inch-supports-etherpunk-2021-hackathon-by-ethindia-5f659927b708
