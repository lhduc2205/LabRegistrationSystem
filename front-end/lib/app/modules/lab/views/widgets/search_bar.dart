// part of lab;
//
// class _SearchBar extends StatelessWidget {
//   const _SearchBar({
//     Key? key,
//     required this.searchController,
//     required this.controller,
//   }) : super(key: key);
//
//   final TextEditingController searchController;
//   final LabController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: searchController,
//       style: TextStyle(color: kFontColorPallets[0]),
//       onChanged: (value) => controller.onChangedSearch(value),
//       decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: kPrimary),
//           ),
//           isDense: true,
//           contentPadding: const EdgeInsets.all(10),
//           prefixIcon: const Icon(IconlyLight.search),
//           suffixIcon: Obx(
//             () => SizedBox(
//               child: controller.searchResult.value.isEmpty
//                   ? const SizedBox()
//                   : InkWell(
//                       child: const Icon(
//                         Icons.clear,
//                         color: kRed,
//                       ),
//                       onTap: () => controller.clearSearchCtrl(),
//                     ),
//             ),
//           )),
//       cursorColor: kDeepBlue,
//     );
//   }
// }
