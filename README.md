# Evolution_of_Trust

#### 1. Description
이 프로젝트는 "신뢰의 진화", 또는 "Evolution of Trust"라고 하는 게임을 R로써 구현을 시도한 것이다. 

R로써 구현한 상황은 다음과 같다 : 

5명의 플레이어는 "협력" 혹은 "배신"의 두가지 선택을 할 수 있다. 협력할 경우 각자 +2점, 상대가 협력하고 본인이 배신할 경우 +3점, 본인이 협력했으나 상대가 배신할 경우 –1점, 나도 상대도 배신할 경우 둘 다 0점을 얻게 된다. 따라서 상호 협력일 경우 +4점, 상호 배신일 경우 0점을 얻게 된다. 협력과 배신할 경우의 얻게되는 점수는 scoreBoard에서 결정해 줄 수 있다.

고려한 4가지의 전략은 다음과 같다 :
* 따라쟁이 (Copycat) : 첫번째 시행은 협력으로 시작해서 다음 시행부터는 전 시행의 상대가 한 선택을 따라한다.
* 배신자 (Devil) : 항상 배신만 선택한다.
* 협력자 (Angel) : 항상 협력만 선택한다.
* 원한을 가진 자(Avengers) : 첫번째 시행은 협력으로 시작한다. 그 후 한번이라도 상대가 배신한다면 끝까지 배신만 선택한다.

#### 2. 다음은 R에서 구현해 보고자 한 내용이다. 

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

#### 3. 함수 설명.
> real_code (Folder)
1. UnknownOpponent.R
   실제로 R로 이 게임을 해볼수 있도록 하는 코드이다.
2. scoreBoard_strategy.R
   score : 각 상황 별로 자신과 상대가 갖는 점수를 저장한 data.frame.
   D, A, Cc, Av : 각 전략의 선택을 구현하는 함수.
3. round_180507.R
   game : 자신과 상대의 전략을 지정하여 n번의 라운드를 진행한 결과를 도출하는 함수.
4. evolution_180508.R
   evolution : 각 전략을 가진 상대방의 수, 한 게임 당 라운드, 진화 과정시 제외되는 인원의 수, 실수 확률을 지정하여 각 전략의 기대 점수가 수렴할 때 까지의 과정을 리스트로 반환하는 함수.
   ev.plot : evolution 함수의 결과를 받아서 각 진화과정 별로 변화하는 전략 인원 수를 plot으로 보여주는 함수.
5. transition_matrix_180509.R
   Pm : 본인의 전략, 각 전략별 인원수, 실수 확률을 지정하여 Transition Matrix를 생성하는 함수.
   stationary : Transition Matrix의 stationary distribution을 도출하는 함수.
6. monte_carlo_simulation_180529.R
   simul : 본인의 전략, 각 전략별 인원수, 실수 확률, 라운드 별 게임 횟수, 반복수, 실수 확률을 지정하여 Pm으로 만들어지는 Transition Matrix를 통하여 시뮬레이션을 하는 함수.
   stat.simul : stationary distribution을 활용하여 시뮬레이션을 하는 함수.
7. transMat_in_Nature.R
   Pm.nat : 상대가 전략 없이 단순한 확률을 통해서 협력, 배신을 선택할 때의 Transition Matrix를 생성하는 함수.
   nat.simul : Pm.nat에서 생성된 Transition Matrix 토대로 시뮬레이션을 하는 함수.
8. main.R
   위의 모든 함수가 통합되어 있다.
   
   

