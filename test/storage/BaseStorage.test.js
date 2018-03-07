/* global describe it artifacts beforeEach */

import { expect } from 'chai'
import { web3 } from '../helpers/w3'
const { accounts } = web3.eth

const BaseStorage = artifacts.require('BaseStorage')

const KEY = 'record'
const ADDRESS = accounts[5]
const NULL_ADDRESS = '0x0000000000000000000000000000000000000000'
const NUM = 5
const LONG_STRING = 'some super long string that never really ends because it just keeps going and going and going and Im not really sure why but I know it doesnt fit in 32 bytes, thats for sure'
const SHORT_STRING = 'I am less than 32 bytes'
const BYTES = ['0xff', '0xff', '0xff']
const BYTES32 = '0x1234123412341234123412341234123412341234123412341234123412341234'
const NULL_BYTES32 = '0x0000000000000000000000000000000000000000000000000000000000000000'
const NEGATIVE_NUM = -5
const NULL_BYTES = '0x'

describe('BaseStorage', () => {
  let baseStorage
  beforeEach(async () => {
    baseStorage = await BaseStorage.new()
  })

  describe('when address is set', () => {
    it('can be retrieved', async () => {
      await baseStorage.setAddress(KEY, ADDRESS)
      const record = await baseStorage.getAddress(KEY)
      expect(record).to.equal(ADDRESS)
    })

    it('can be deleted', async () => {
      await baseStorage.setAddress(KEY, ADDRESS)
      await baseStorage.deleteAddress(KEY)
      const record = await baseStorage.getAddress(KEY)
      expect(record).to.equal(NULL_ADDRESS)
    })
  })

  describe('when uint is set', () => {
    it('can be retrieved', async () => {
      await baseStorage.setUint(KEY, NUM)
      const record = await baseStorage.getUint(KEY)
      expect(record.toNumber()).to.equal(NUM)
    })

    it('can be deleted', async () => {
      await baseStorage.setUint(KEY, NUM)
      await baseStorage.deleteUint(KEY)
      const record = await baseStorage.getUint(KEY)
      expect(record.toNumber()).to.equal(0)
    })
  })

  describe('when string is set', () => {
    it('can be retrieved', async () => {
      await baseStorage.setString(KEY, LONG_STRING)
      const record = await baseStorage.getString(KEY)
      expect(record).to.equal(LONG_STRING)
    })

    it('can be deleted', async () => {
      await baseStorage.setString(KEY, LONG_STRING)
      await baseStorage.deleteString(KEY)
      const record = await baseStorage.getString(KEY)
      expect(record).to.equal('')
    })
  })

  describe('when bytes is set', () => {
    it('can be retrieved', async () => {
      await baseStorage.setBytes(KEY, LONG_STRING)
      const record = await baseStorage.getBytes(KEY)
      expect(web3.toAscii(record)).to.equal(LONG_STRING)
    })

    it('can be deleted', async () => {
      await baseStorage.setBytes(KEY, LONG_STRING)
      await baseStorage.deleteBytes(KEY)
      const record = await baseStorage.getBytes(KEY)
      expect(web3.toAscii(record)).to.equal('')
    })
  })

  describe('when bytes32 is set', () => {
    it('can be retrieved', async () => {
      await baseStorage.setBytes32(KEY, BYTES32)
      const record = await baseStorage.getBytes32(KEY)
      expect(record).to.equal(BYTES32)
    })

    it('can be deleted', async () => {
      await baseStorage.setBytes32(KEY, BYTES32)
      await baseStorage.deleteBytes32(KEY)
      const record = await baseStorage.getBytes32(KEY)
      expect(record).to.equal(NULL_BYTES32)
    })
  })

  describe('when bool is set', () => {
    it('can be retrieved', async () => {
      await baseStorage.setBool(KEY, true)
      const record = await baseStorage.getBool(KEY)
      expect(record).to.equal(true)
    })

    it('can be deleted', async () => {
      await baseStorage.setBool(KEY, true)
      await baseStorage.deleteBool(KEY)
      const record = await baseStorage.getBool(KEY)
      expect(record).to.equal(false)
    })
  })

  describe('when int is set', () => {
    it('can be retrieved', async () => {
      await baseStorage.setInt(KEY, NEGATIVE_NUM)
      const record = await baseStorage.getInt(KEY)
      expect(record.toNumber()).to.equal(NEGATIVE_NUM)
    })

    it('can be deleted', async () => {
      await baseStorage.setInt(KEY, NEGATIVE_NUM)
      await baseStorage.deleteInt(KEY)
      const record = await baseStorage.getInt(KEY)
      expect(record.toNumber()).to.equal(0)
    })
  })
})
