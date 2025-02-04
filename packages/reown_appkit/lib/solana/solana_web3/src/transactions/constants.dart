/// Maximum over-the-wire size of a Transaction
///
/// 1280 is IPv6 minimum MTU
/// 40 bytes is the size of the IPv6 header
/// 8 bytes is the size of the fragment header
const packetDataSize = 1280 - 40 - 8;

/// Version message number prefix flag.
const versionPrefixFlag = 0x80;

/// Version message number prefix mask.
const versionPrefixMask = 0x7f;
