const fz = require('zigbee-herdsman-converters/converters/fromZigbee');
const tz = require('zigbee-herdsman-converters/converters/toZigbee');
const exposes = require('zigbee-herdsman-converters/lib/exposes');
const reporting = require('zigbee-herdsman-converters/lib/reporting');
const extend = require('zigbee-herdsman-converters/lib/extend');
const e = exposes.presets;
const ea = exposes.access;
const tuya = require('zigbee-herdsman-converters/lib/tuya');

const definition = {
   
    fingerprint:[
        {modelID: 'TS0601', manufacturerName: '_TZE200_vmcgja59'},
        {modelID: 'TS0601', manufacturerName: '_TZE204_dvosyycn'},
    ], 
    model: 'TS0601_switch_8_gang',
    vendor: 'TuYa',
    description: '8 gang switch',
    fromZigbee: [tuya.fz.datapoints],
    toZigbee: [tuya.tz.datapoints],
    configure: tuya.configureMagicPacket,
    exposes: [
        tuya.exposes.switch().withEndpoint('l1'),
        tuya.exposes.switch().withEndpoint('l2'),
        tuya.exposes.switch().withEndpoint('l3'),
        tuya.exposes.switch().withEndpoint('l4'),
        tuya.exposes.switch().withEndpoint('l5'),
        tuya.exposes.switch().withEndpoint('l6'),
        tuya.exposes.switch().withEndpoint('l7'),
        tuya.exposes.switch().withEndpoint('l8'),
    ],
    endpoint: (device) => {
        return {'l1': 1, 'l2': 1, 'l3': 1, 'l4': 1, 'l5': 1, 'l6': 1, 'l7': 1, 'l8': 1};
    },
    meta: {
        multiEndpoint: true,
        tuyaDatapoints: [
            [1, 'state_l1', tuya.valueConverter.onOff],
            [2, 'state_l2', tuya.valueConverter.onOff],
            [3, 'state_l3', tuya.valueConverter.onOff],
            [4, 'state_l4', tuya.valueConverter.onOff],
            [5, 'state_l5', tuya.valueConverter.onOff],
            [6, 'state_l6', tuya.valueConverter.onOff],
            [0x65, 'state_l7', tuya.valueConverter.onOff],
            [0x66, 'state_l8', tuya.valueConverter.onOff],
        ],
    },
};

module.exports = definition;
