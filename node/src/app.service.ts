import { Logger } from '@nestjs/common';
import { Injectable, OnModuleInit } from '@nestjs/common';
import { ethers } from "ethers";

import * as RandomOracle from './abi/RandomOracle.json';
import * as RandomWrapper from './abi/RandomWrapper.json';

@Injectable()
export class AppService implements OnModuleInit {

  private readonly SecretWalletPrivateKey = '49117ef2c8d355c7662755bca2d3647ce118c6db76d4d50d74f8aea3f612aef3';
  private readonly SecretWalletAddress = '0x546C5F81C3F09B98cAE8C63Fb2bEe0828F03fC66';
  private readonly RandomWrapperAddress = '0x113A4CeDeDc2ed86C99d82D980B7D3b4F63dac4f';
  private readonly RandomOracleAddress = '0x2c0478155Aa0C6434a583eb7723c6945A5b63532';
  private readonly ethersProvider = new ethers.providers.JsonRpcProvider('https://evm-t3.cronos.org');

  async onModuleInit() {
    const signer = new ethers.Wallet(this.SecretWalletPrivateKey, this.ethersProvider);
    const randomOracleContract = new ethers.Contract(this.RandomOracleAddress, RandomOracle, this.ethersProvider);
    const randomOracleConnectedContract = randomOracleContract.connect(signer);

    randomOracleConnectedContract.on("RandomNumberRequested", async (callerAddress: string, id: string, min: number, max: number) => {
      const rnd = this.getRandomIntInRange(min, max);
      Logger.log(`New random request. CallerAddress:${callerAddress}, id: ${id}, min: ${min}, max: ${max}, rnd: ${rnd}`);
      await randomOracleConnectedContract.returnRandomNumber(this.SecretWalletAddress, rnd, callerAddress, id);
    });

    const randomWrapperContract = new ethers.Contract(this.RandomWrapperAddress, RandomWrapper, this.ethersProvider);
    randomWrapperContract.on("RandomNumberReceived", async (randomNumber: string, id: number) => {
      Logger.log(`New random received. randomNumber:${randomNumber}, id: ${id}`);
    });
  }

  private getRandomIntInRange(min: number, max: number) {
    min = Math.ceil(min);
    max = Math.floor(max) + 1;
    return Math.floor(Math.random() * (max - min)) + min;
  }
}