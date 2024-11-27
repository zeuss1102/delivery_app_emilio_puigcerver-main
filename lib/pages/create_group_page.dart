import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app_emilio_puigcerver/models/group.dart';
import 'package:delivery_app_emilio_puigcerver/providers/group_provider.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();
  final List<Member> _members = [];

  void _addMember() {
    setState(() {
      _members.add(Member(id: DateTime.now().toString(), name: '', salary: 0));
    });
  }

  void _saveGroup() {
    Group newGroup = Group(id: DateTime.now().toString(), name: _groupNameController.text, members: _members);
    Provider.of<GroupProvider>(context, listen: false).addGroup(newGroup);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Grupo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _groupNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Grupo',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _members.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              _members[index].name = value;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Nombre del Miembro',
                              border: OutlineInputBorder(),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (value) {
                              _members[index].salary = double.parse(value);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Salario',
                              border: OutlineInputBorder(),
                              filled: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _addMember,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Usar colores estándar
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Agregar Miembro',
                    style: TextStyle(color: Colors.black), // Letra negra
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveGroup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Usar colores estándar
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Guardar Grupo',
                    style: TextStyle(color: Colors.black), // Letra negra
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


