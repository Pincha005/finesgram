import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class RappelPage extends StatefulWidget {
  const RappelPage({super.key});

  @override
  State<RappelPage> createState() => _RappelPageState();
}

class _RappelPageState extends State<RappelPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime? _dateDebut;
  TimeOfDay? _heure;
  String _frequence = 'Une fois';
  bool _isLoading = false;

  final List<String> _frequences = [
    'Une fois',
    'Tous les jours',
    'Hebdomadaire',
    'Mensuel',
  ];

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    tz.initializeTimeZones();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateDebut ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null && picked != _dateDebut) {
      setState(() => _dateDebut = picked);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _heure ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _heure) {
      setState(() => _heure = picked);
    }
  }

  Future<void> _enregistrerRappel() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateDebut == null || _heure == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Veuillez sélectionner une date et une heure')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final DateTime dateTime = DateTime(
        _dateDebut!.year,
        _dateDebut!.month,
        _dateDebut!.day,
        _heure!.hour,
        _heure!.minute,
      );

      // Enregistrement dans Firestore
      await FirebaseFirestore.instance.collection('rappels').add({
        'nom': _nomController.text.trim(),
        'frequence': _frequence,
        'date': Timestamp.fromDate(dateTime),
        'note': _noteController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      // Planification de la notification
      await _scheduleNotification(
        _nomController.text.trim(),
        _noteController.text.trim(),
        dateTime,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rappel enregistré avec succès!')),
      );

      // Réinitialisation du formulaire
      _formKey.currentState!.reset();
      setState(() {
        _dateDebut = null;
        _heure = null;
        _frequence = 'Une fois';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _scheduleNotification(
    String title,
    String body,
    DateTime dateTime,
  ) async {
    await _notificationsPlugin.zonedSchedule(
      0, // ID de notification
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'rappel_channel_id',
          'Rappels',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: _getDateTimeComponents(),
    );
  }

  DateTimeComponents? _getDateTimeComponents() {
    switch (_frequence) {
      case 'Tous les jours':
        return DateTimeComponents.time;
      case 'Hebdomadaire':
        return DateTimeComponents.dayOfWeekAndTime;
      case 'Mensuel':
        return DateTimeComponents.dayOfMonthAndTime;
      default:
        return null; // Une fois
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un rappel'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom du rappel*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.trim().isEmpty ?? true
                    ? 'Ce champ est obligatoire'
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _frequence,
                items: _frequences
                    .map((f) => DropdownMenuItem(
                          value: f,
                          child: Text(f),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _frequence = value!),
                decoration: const InputDecoration(
                  labelText: 'Fréquence*',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date*',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _dateDebut == null
                              ? 'Sélectionner une date'
                              : '${_dateDebut!.day}/${_dateDebut!.month}/${_dateDebut!.year}',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _pickTime,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Heure*',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _heure == null
                              ? 'Sélectionner une heure'
                              : _heure!.format(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _enregistrerRappel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('ENREGISTRER LE RAPPEL'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
