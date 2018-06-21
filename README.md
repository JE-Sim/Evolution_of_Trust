# Evolution_of_Trust

#### 1. Description
이 프로젝트는 "신뢰의 진화", 또는 "Evolution of Trust"라고 하는 게임을 R로써 구현을 시도한 것이다. 

5명의 플레이어는 "협력" 혹은 "배신"의 두가지 선택을 할 수 있다. 협력할 경우 +2점, 배신할 경우 +1점, 따라서 상호 협력일 경우 +4점, 상호 배신일 경우 0점을 얻게 된다. 협력과 배신할 경우의 얻게되는 점수는 scoreBoard에서 결정해 줄 수 있다.

5명의 상대의 성격은 다음과 같다.
- 따라쟁이 (Copycat) : 첫번째 시행은 협력으로 시작해서 다음 시행부터는 전 시행의 상대가 한 선택을 따라한다.
- 배신자 (Devil) : 항상 배신만 선택한다. 
- 협력자 (Angel) : 항상 협력만 선택한다.
- 원한을 가진 자(Avengers) : 첫번째 시행은 협력으로 시작한다. 그 후 한번이라도 상대가 배신한다면 끝까지 배신만 선택한다. 

#### 2. 다음은 R에서 구현해 보고자 한 내용이다.. 

1. 상대를 모르는 상태에서 사용자가 직접 "협력" 혹은 "배신"을 선택하여 사용자와 상대방이 얻을 수 있는 기대점수를 계산한다. (UnknwonOpponent.r)
(상대의 숫자만 알 수 있다.) 

2. 사용자를 "Angel", "Devil", "Copycat", "Avengers" 중 하나의 성격을 가지도록 설정하고 상대방도 역시 4가지 특징 중 하나로 설정하여 Angel:Devil, Angel:Copycat, Angel:Avengers, Devil:Copycat, Devil:Avengers, Copycat:Avengers의 얻을 수 있는 점수를 계산한다. 5번의 협력, 배신 시행을 통해 (round = 5, 교체 가능) 1 game 당 얻게되는 점수의 기댓값. (evolution.r)

3. 위의 2)를 바탕으로 evolution 코드로 4명의 성격의 플레이어가 모두 참여했을 때, 어떤 성격의 플레이어가 살아남을 가능성이 높은지를 살펴볼 수 있다. (evolution.r)

3-1) 우선 전체 게임에 참여할 플레이어들의 수를 결정한다. 

3-2) 한 게임 당 플레이어들 중 2명을 선택하여 각 match에서 5번의 라운드가 돌아간다. 정해진 20명(조정 가능)의 210개의 match에서 각 match마다 5번의 round를 통해 게임에 참여한 사람들의 점수가 계산되고, 그것이 반복되면서 1번째 게임의 플레이어들이 얻은 총 점수를 구할 수 있다. 

3-3) 가장 낮은 점수를 보유한 플레이어(성격) 5명을 제거하고, 가장 높은 점수의 기댓값을 가진 플레이어(성격) 5명으로 공백을 메꾸어 총 플레이어 수를 유지해 준다. (뺴는 사람 수는 코드에서 조정 가능) 이 과정을 정해진 game 수대로 반복한다. 

3-4) 만약 정해진 게임 수(iter)보다 먼저 각 게임 참여자 characteristic의 점수들의 수렴이 이루어지면 거기서 멈춘다. 

4. 이번에는 각 player 성격 별로 transition matrix를 구현해 Monte Carlo Simulation을 통해 evolution 과정을 진행해 보았다. 

4-1) Angel, Devil, Avengers, Copycat 4개의 플레이어 성격별로 각기 다른 transition matrix를 구현했다. (transition_matrix.r)

4-2) 구성된 transition matrix를 이용하여 Monte Carlo Simulation을 진행하였다. 이를 통해 각 플레이어 성격(전략) 별 얻을 수 있는 점수의 기댓값을 계산할 수 있다. 이를 통해서 어떤 전략이 가장 높은 점수의 기댓값을 얻게 되는지를 살펴본다. 


http://ncase.me/trust//

