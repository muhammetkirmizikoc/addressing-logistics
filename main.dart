import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

void main() {
  runApp(DepoBarkodApp());
}

class DepoBarkodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depo Barkod Sistemi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFF3B82F6),
          secondary: const Color(0xFF64748B),
          tertiary: const Color(0xFF94A3B8),
          surface: const Color(0xFFF8FAFC),
          surfaceVariant: const Color(0xFFF1F5F9),
          outline: const Color(0xFFE2E8F0),
        ),
      ),
      home: LocationBuilderPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LocationBuilderPage extends StatefulWidget {
  @override
  _LocationBuilderPageState createState() => _LocationBuilderPageState();
}

class _LocationBuilderPageState extends State<LocationBuilderPage> {
  final List<String> corridors = List.generate(12, (i) => 'Z${i + 1}');
  final List<String> rows = List.generate(92, (i) => (i + 1).toString().padLeft(3, '0'));
  final List<String> sides = ['L', 'R'];
  final List<String> shelves = ['10', '20', '30', '40', '50', '60'];

  late FixedExtentScrollController _corridorController;
  late FixedExtentScrollController _rowController;
  late FixedExtentScrollController _sideController;
  late FixedExtentScrollController _shelfController;

  int _corridorIndex = 0;
  int _rowIndex = 0;
  int _sideIndex = 0;
  int _shelfIndex = 0;

  @override
  void initState() {
    super.initState();
    _corridorController = FixedExtentScrollController(initialItem: _corridorIndex);
    _rowController = FixedExtentScrollController(initialItem: _rowIndex);
    _sideController = FixedExtentScrollController(initialItem: _sideIndex);
    _shelfController = FixedExtentScrollController(initialItem: _shelfIndex);
  }

  String get fullLocationCode {
    return '${corridors[_corridorIndex]}-${rows[_rowIndex]}-${shelves[_shelfIndex]}-${sides[_sideIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            children: [
              // Büyük Barkod Alanı
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: BarcodeWidget(
                        data: fullLocationCode,
                        barcode: Barcode.code128(),
                        width: double.infinity,
                        height: double.infinity,
                        drawText: false,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Kompakt Lokasyon Kodu
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                margin: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  fullLocationCode,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                    letterSpacing: 1.2,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              
              // Modern Kayar Seçimler
              Container(
                height: 280,
                margin: EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double availableWidth = constraints.maxWidth - 32;
                    double pickerWidth = availableWidth * 0.22;
                    
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildModernWheelPicker(
                            'Koridor',
                            corridors,
                            _corridorController,
                            (index) => setState(() => _corridorIndex = index),
                            colorScheme,
                            Icons.view_column_rounded,
                            pickerWidth,
                          ),
                          _buildModernWheelPicker(
                            'Sıra',
                            rows,
                            _rowController,
                            (index) => setState(() => _rowIndex = index),
                            colorScheme,
                            Icons.format_list_numbered_rounded,
                            pickerWidth,
                          ),
                          _buildModernWheelPicker(
                            'Raf',
                            shelves,
                            _shelfController,
                            (index) => setState(() => _shelfIndex = index),
                            colorScheme,
                            Icons.shelves,
                            pickerWidth,
                          ),
                          _buildModernWheelPicker(
                            'Yön',
                            sides,
                            _sideController,
                            (index) => setState(() => _sideIndex = index),
                            colorScheme,
                            Icons.compare_arrows_rounded,
                            pickerWidth,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernWheelPicker(
    String title, 
    List<String> options, 
    FixedExtentScrollController controller, 
    Function(int) onChanged,
    ColorScheme colorScheme,
    IconData icon,
    double width,
  ) {
    return Container(
      width: width,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.06),
                    spreadRadius: 0,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: 45,
                  diameterRatio: 6,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: onChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: options.length,
                    builder: (context, index) {
                      bool isSelected = index == controller.selectedItem;
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: isSelected
                            ? BoxDecoration(
                                color: const Color(0xFF3B82F6).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF3B82F6).withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              )
                            : null,
                        child: Text(
                          options[index],
                          style: TextStyle(
                            fontSize: isSelected ? 24 : 16,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected 
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF64748B),
                            letterSpacing: isSelected ? 0.5 : 0.2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
