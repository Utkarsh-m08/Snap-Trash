import 'package:flutter/material.dart';
import 'package:SnapTrash/properties/colourProp.dart';
  List<User> users = [
    User('Polly Gray', 100, 'assets/images/leaderboard/1.jpeg'),
    User('Tom Patton', 90, 'assets/images/leaderboard/2.jpeg'),
    User('Gregory', 80, 'assets/images/leaderboard/3.jpeg'),
    User('George Estrada', 70, 'assets/images/leaderboard/4.jpeg'),
    User('Rhoda James', 60, 'assets/images/leaderboard/5.jpeg'),
    User('Brent Ortega', 50, 'assets/images/leaderboard/6.jpeg'),
    User('You', 40, 'assets/images/leaderboard/7.jpeg'),
    User('Clara Hunt', 30, 'assets/images/leaderboard/8.jpeg'),
    User('Milton Fuller', 20, 'assets/images/leaderboard/9.jpeg'),
    User('Kathryn Flores', 10, 'assets/images/leaderboard/10.jpeg'),
  ];
class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: rang6,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: rang6,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: const TopUsers(),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.497,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: rang6Light,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              ),
              child: ListView.builder(
                itemCount: users.length - 3,
                itemBuilder: (context, index) {
                  final adjustedIndex = index + 3;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    // color: rang6,
                    decoration: BoxDecoration(
                      color: users[adjustedIndex].name == 'You' ? Colors.white : rang6,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical:8, horizontal: 20),
                      title: Row(
                        children: [
                          Text(
                            '${adjustedIndex + 1}',
                            style: TextStyle(
                              color: users[adjustedIndex].name == 'You' ? Colors.black : Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          CircleAvatar(
                          backgroundImage: AssetImage(users[adjustedIndex].image),
                          radius: 25,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            users[adjustedIndex].name,
                            style: TextStyle(
                              color: users[adjustedIndex].name == 'You' ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '${users[adjustedIndex].points}pts',
                        style: TextStyle(
                              color: users[adjustedIndex].name == 'You' ? Colors.black : Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TopUsers extends StatelessWidget {
  const TopUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/leaderboard/2.jpeg'),
                  radius: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25, top: 70),
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 15,
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                users[1].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${users[1].points} pts',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                backgroundImage: AssetImage('assets/images/leaderboard/1.jpeg'),
                radius: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, top: 70),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 15,
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      )
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              users[0].name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '${users[0].points} pts',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/leaderboard/3.jpeg'),
                  radius: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25, top: 70),
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 15,
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        )
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                users[2].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${users[2].points} pts',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class User {
  final String name;
  final int points;
  final String image;

  User(this.name, this.points, this.image);
}

