import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Page'),
      ),
      body: ListView(
        children: const <Widget>[
          ExpansionTile(
            title: Text('What to do in a fire?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '1. Stay calm and evacuate immediately.\n'
                  '2. Use a cloth to cover your nose and mouth to avoid inhaling smoke.\n'
                  '3. If trapped, stay near a window and signal for help.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do in case of a medical emergency?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '1. Call emergency services immediately.\n'
                  '2. Provide first aid if trained.\n'
                  '3. Keep the patient calm and comfortable.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do in case of a natural disaster?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '1. Stay indoors if safe, or seek shelter.\n'
                  '2. Follow local emergency alerts.\n'
                  '3. Avoid windows and seek high ground if necessary.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do when there’s a crime in progress?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'For active crimes like burglary, assault, or any situation where immediate police intervention is necessary.\n'
                  '1. Stay out of sight if possible.\n'
                  '2. Avoid confrontation and remain quiet.\n'
                  '3. Call for help as soon as it’s safe.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do when you notice suspicious activity?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'For reporting suspicious individuals or behavior, like someone loitering, trespassing, or acting strangely in public.\n'
                  '1. Observe from a safe distance.\n'
                  '2. Do not confront the individual.\n'
                  '3. Report details, such as appearance and behavior, to authorities.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do when there’s a traffic accident?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'When you need assistance for road accidents, collisions, or other traffic-related incidents.\n'
                  '1. Check for injuries and call emergency services if needed.\n'
                  '2. If safe, move vehicles out of the road.\n'
                  '3. Collect information from other drivers involved.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do when there’s a domestic disturbance?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'For situations like domestic violence, family disputes, or loud arguments.\n'
                  '1. Stay in a safe area.\n'
                  '2. Avoid getting directly involved.\n'
                  '3. Report what you hear and observe to authorities.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do when there’s an animal-related incident?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'For situations involving dangerous or lost animals, such as stray dogs, snake sightings, or wildlife in populated areas.\n'
                  '1. Stay calm and avoid sudden movements.\n'
                  '2. Don’t approach the animal.\n'
                  '3. Contact animal control or emergency services for assistance.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
                'What to do when there’s an accident involving hazardous materials?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'For incidents involving chemical spills, gas leaks, or other hazardous substances.\n'
                  '1. Leave the area immediately if you smell gas or notice chemical odors.\n'
                  '2. Avoid touching any spilled substances.\n'
                  '3. Notify emergency services and keep others away.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What to do when there’s a mental health crisis?'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Assistance for situations involving individuals in emotional distress, mental health episodes, or self-harm risk.\n'
                  '1. Approach calmly and speak in a gentle tone.\n'
                  '2. Avoid making sudden movements.\n'
                  '3. Keep yourself and others safe and contact mental health services or emergency responders.',
                ),
              ),
            ],
          ),
          // Add more tiles as needed
        ],
      ),
    );
  }
}
