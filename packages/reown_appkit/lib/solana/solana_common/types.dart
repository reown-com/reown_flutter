//! Types
/// ------------------------------------------------------------------------------------------------
library;

// Integers
//
// Native applications (mobile/desktop) representations:
//
//   [int]    = 64-bit signed two's complement.
//              -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
//
//   [double] = 64-bit floating point.
//              0,
//              2.2250738585072014e-308 to 1.7976931348623158e+308,
//              -1.7976931348623158e+308 to -2.2250738585072014e-308
//
// TODO: Handle `u64` and `usize` integer representations correctly.
//
//   [u64]   = Values >= 2^63 will overflow.
//
//   [usize] = Values >= 2^63 will overflow on 64-bit architectures.
//
typedef i8 = int; // ignore: camel_case_types
typedef u8 = int; // ignore: camel_case_types
typedef i16 = int; // ignore: camel_case_types
typedef u16 = int; // ignore: camel_case_types
typedef i32 = int; // ignore: camel_case_types
typedef u32 = int; // ignore: camel_case_types
typedef i64 = int; // ignore: camel_case_types
typedef u64 = int; // ignore: camel_case_types
typedef bu64 = BigInt; // ignore: camel_case_types
typedef isize = int; // ignore: camel_case_types
typedef usize = int; // ignore: camel_case_types

// Floats
typedef f32 = double; // ignore: camel_case_types
typedef f64 = double; // ignore: camel_case_types
