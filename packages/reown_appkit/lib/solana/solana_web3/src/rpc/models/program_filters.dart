// /// Imports
// /// ------------------------------------------------------------------------------------------------

// import 'package:reown_appkit/solana/solana_common/models.dart';
// import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
// import 'package:reown_appkit/solana/solana_jsonrpc/models.dart' show MemCmp;

// /// Program Filters
// /// ------------------------------------------------------------------------------------------------

// class ProgramFilters extends Serializable {

//   /// Filter results using a filter objects. The account must meet all filter criteria to be
//   /// included in results.
//   const ProgramFilters({
//     required this.memcmp,
//     required this.dataSize,
//   });

//   /// Compares a provided series of bytes with the program account data at a particular offset.
//   final MemCmp? memcmp;

//   /// Compares the program account data length with the provided data size.
//   final u64? dataSize;

//   @override
//   Map<String, dynamic> toJson() => {
//     'memcmp': memcmp?.toJson(),
//     'dataSize': dataSize,
//   };

//   List<Map<String, dynamic>> toJsonList() => [
//     { 'memcmp': memcmp?.toJson() },
//     { 'dataSize': dataSize }
//   ];

//   List<Map<String, dynamic>> toJsonListCleaned() => [
//     if (memcmp != null)
//       { 'memcmp': memcmp!.toJson() },
//     if (dataSize != null)
//       { 'dataSize': dataSize }
//   ];
// }
