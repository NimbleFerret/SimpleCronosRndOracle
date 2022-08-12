## Description

Very simple implementation of random oracle for solidity contracts. 
Designed for Moralis x Cronos game hackathon (https://moralis.io/cronos-hackathon/) and will be used to generate random game character stats for NFTs and stuff.

## From scratch guide
```bash
1) Check inspired links in order to understand basic ideas
2) Install node 16+
3) Install Metamask and generate a wallet, create second account in it
4) Go to test cronos faucet and get some money for both accs (https://cronos.org/faucet)
5) Put your account's private keys and seed phrases into .env and app.service.ts files
6) Deploy contracts into cronos test net. From truffle folder: npm i + npm run (os)-deploy-contracts-cronos
7) Save RandomOracle and RandomWrapper contract addresses
8) Verify and publish each contracts here https://testnet.cronoscan.com/address/CONTRACT_ADDRESS_HERE
9) Write externalServiceSecret for RandomOracle and randomOracle for RandomWrapper contrats on the cronoscan
10) Run node.js app by doing: npm i + npm run start
11) Try request some random from RandomWrapper contract (Call getRandomNumber func)
12) Check node.js app logs
```

## Node.js app logs example:
```bash
[Nest] 23992  - 08/12/2022, 2:15:59 PM LOG [NestFactory] Starting Nest application...
[Nest] 23992  - 08/12/2022, 2:15:59 PM LOG [InstanceLoader] AppModule dependencies initialized +23ms
[Nest] 23992  - 08/12/2022, 2:15:59 PM LOG [NestApplication] Nest application successfully started +83ms
[Nest] 23992  - 08/12/2022, 2:16:40 PM LOG New random request. CallerAddress:0x113A4CeDeDc2ed86C99d82D980B7D3b4F63dac4f, id: 109, min: 10, max: 30, rnd: 30
[Nest] 23992  - 08/12/2022, 2:16:55 PM LOG New random received. randomNumber:30, id: 109
```

## Inspired by
https://docs.replit.com/tutorials/build-smart-contract-oracle#nodejs-data-provider
https://cronos.org/docs/getting-started/cronos-smart-contract.html#truffle-deploy-erc20-contract