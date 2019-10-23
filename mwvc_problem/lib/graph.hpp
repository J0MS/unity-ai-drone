/*-----------------------------------------<graph.cpp>-----------------------------------------*/
#ifndef graph_H
#define graph_H

class graph{
public:
  int sequence;
  double **G;

public:
  graph();
  graph(int);
  void updateWeight(int, int, double);
  double getWeight(int, int);
};

#endif

/*-----------------------------------------</graph.cpp>-----------------------------------------*/
