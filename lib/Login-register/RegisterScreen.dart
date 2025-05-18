import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _gender;
  bool _agree = false;
  DateTime? _selectedDate;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF34C759),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      'โปรดกรอกข้อมูลส่วนตัว',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(height: 1, width: double.infinity, color: const Color(0xFFE5E5EA)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildLabel("ชื่อ - นามสกุล *"),
              _buildTextField(_nameController, 'ชื่อ - นามสกุล', false),
              _buildLabel("อีเมลของคุณ *"),
              _buildTextField(_emailController, 'อีเมลของคุณ', false),
              _buildLabel("รหัสผ่านของคุณ"),
              _buildTextField(_passwordController, 'รหัสผ่าน', true),
              _buildLabel("ยืนยันรหัสผ่านของคุณ"),
              _buildTextField(_confirmPasswordController, 'กรุณณายืนยันรหัสผ่านของคุณอีกครั้ง', true),
              _buildLabel('วัน เดือน ปีเกิด'),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5EA)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'วัน เดือน ปีเกิด'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: TextStyle(
                          color: _selectedDate == null ? Colors.grey : Colors.black,
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              _buildLabel('เพศ'),
              Row(
                children: [
                  _buildGenderRadio(0, 'ชาย'),
                  _buildGenderRadio(1, 'หญิง'),
                  _buildGenderRadio(2, 'ไม่ระบุเพศ'),
                ],
              ),
              _buildLabel("เบอร์โทรศัพท์มือถือ  *"),
              _buildTextField(_phoneController, 'เบอร์โทรศัพท์มือถือ', false, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agree,
                    activeColor: const Color(0xFF34C759),
                    onChanged: (bool? value) {
                      setState(() {
                        _agree = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text('ยินยอมให้เข้าถึงข้อมูลและเข้าใช้บริการบางส่วน'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34C759),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _agree) {
                      // ดำเนินการสมัครสมาชิก
                    }
                  },
                  child: const Text(
                    'สมัครสมาชิก',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool obscureText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF34C759), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'กรุณากรอก $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderRadio(int value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<int>(
          value: value,
          groupValue: _gender,
          activeColor: const Color(0xFF34C759),
          onChanged: (int? val) {
            setState(() {
              _gender = val;
            });
          },
        ),
        Text(label),
        const SizedBox(width: 10),
      ],
    );
  }
}
