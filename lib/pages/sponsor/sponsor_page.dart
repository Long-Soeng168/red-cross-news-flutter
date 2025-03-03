import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SponsorPage extends StatelessWidget {
  const SponsorPage({super.key});

  @override
  Widget build(BuildContext context) {
    String htmlContent = """
      <h2>សេចក្តីប្រកាសព័ត៌មាន</h2>
      <h3>ស្តីពី</h3>
      <h3>ខួបទី ១៦០ ទិវាពិភពលោក កាកបាទក្រហម និងអឌ្ឍចន្ទក្រហម ៨ ឧសភា ២០២៣</h3>
      <p>ក្រោមប្រធានបទ <b>"រួមគ្នាជាមួយកាកបាទក្រហមកកម្ពុជា ដើម្បីបរិយាបន្នសង្គម"</b></p>
      
      <p>កាកបាទក្រហមកម្ពុជា ដែលមាន <b>ហ្លួងម៉ែ នរោត្តម មុនិនាថ សីហនុ</b> ជាព្រះប្រធានកិត្តិយស និង 
      <b>សម្តេចកិត្តិ ព្រឹទ្ធបណ្ឌិត ប៊ុន រ៉ានី ហ៊ុន សែន</b> ជាប្រធានមានកិត្តិយសសូមអំពាវនាវ...</p>
      
      <h4>ធនាគារពាណិជ្ជកម្មក្រៅប្រទេសនៃកម្ពុជា (FTB)</h4>
      <ul>
        <li><b>គណនីឈ្មោះ:</b> Cambodian Red Cross (កាកបាទក្រហមកម្ពុជា)</li>
        <li><b>គណនីប្រាក់រៀល:</b> 100004348127</li>
        <li><b>គណនីប្រាក់ដុល្លារ:</b> 300001709996</li>
      </ul>
      
      <h4>ធនាគារវឌ្ឍនៈអាស៊ីចំកាត់ (ABA)</h4>
      <ul>
        <li><b>គណនីឈ្មោះ:</b> PUM CHANTINIE AND MEN NEARY SOPHEAK AND LIM SAY</li>
        <li><b>គណនីប្រាក់រៀល:</b> 180 255 333</li>
        <li><b>គណនីប្រាក់ដុល្លារ:</b> 180 255 168</li>
      </ul>
      
      <h4>ព័ត៌មានបន្ថែម</h4>
      <p><b>លោកជំទាវ ពុំ ចន្ទីនី:</b> 012 921 105</p>
      <p><b>លោកជំទាវ ម៉ែន នារីសោភ័គ:</b> 012 810 854</p>
      <p><b>ឯកឧត្តម ឌួង អេលីត:</b> 017 248 888</p>
    """;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sponsor'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Html(
            data: htmlContent,
          ),
        ),
      ),
    );
  }
}
