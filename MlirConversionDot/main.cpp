//===--------------------------------------------------------------------===//
//   Simple conversion script is basis of `affine` mlir representation
//   to dot format graphical layout
//   Author: Zhao Fangyu
//   Date: 2023.10.20
//===--------------------------------------------------------------------===//

#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <map>
#include <fstream>

using namespace  std;
#define DEBUG
/// Record the count of each operator appearance
map<string,int> Operator_Count={
        {"arith.constant",0},
        {"memref.alloc",0},
        {"affine.for",0},
        {"affine.store",0},
        {"affine.load",0},
        {"memref.copy",0},
        {"memref.dealloc",0},
        {"affine.load",0},
        {"arith.mulf",0},
        {"arith.addf",0}
};

//===--------------------------------------------------------------------===//
// Dot Edge Class
// Define Two variable represent as SourceNode and SinkNode: sourceNode -> sinknode
// eg:inner_affine_loop1 -> inner_affine_loop2
//===--------------------------------------------------------------------===//
class Edge{

     const string sourceNode;
     const string sinkNode;
     string edge;

public:

/// Edge class constructor
    Edge(const string &sourceNode, const string &sinkNode) : sourceNode(sourceNode), sinkNode(sinkNode) {
        edge = createEdge();
    }

    Edge(const string &sourceNode, const string &sinkNode, bool flag) : sourceNode(sourceNode), sinkNode(sinkNode) {
        edge = createBackEdge();
    }
/// Insert additional operator
    string createEdge() {
        return sourceNode+" -> "+sinkNode+";";
    }
    /// Another member function with regard to Traverse Back Edge
    string createBackEdge() {
        return sourceNode+" -> "+sinkNode+" [label=\"back\"];";
    }
/// Getter function
    const string &getEdge() const {
        return edge;
    }

    const string &getSourceNode() const {
        return sourceNode;
    }

    const string &getSinkNode() const {
        return sinkNode;
    }

};

//===--------------------------------------------------------------------===//
// Dot Node Class
// Define the declaration of each of node on the graph
// Obey the following abstract grammar syntax
// node_stmt	:	node_id [ attr_list ]
// eg: inner_affine_loop1[label="Inner Loop 1"];
//===--------------------------------------------------------------------===//
class Node{
    const string inputLiteral;
    string singleNode;
public:

/// Node class constructor
    explicit Node(const string &inputLiteral) : inputLiteral(inputLiteral) {
            singleNode=addNode();
    }
/// This utility function performs a collection of string operator string transformation
    string addNode() {
        string temp;
        temp = inputLiteral;
       if(!inputLiteral.compare("affine.for")) {
           /// Change node variable name as an identifier
           /// eg. from affine.for to affine_for_loop_str(number)
           return temp.replace(temp.find('.'), 1, "_", 1) + "_loop" + to_string(Operator_Count["affine.for"]);
       }else if(!inputLiteral.compare("arith.addf")){
           ///Change node variable name as an identifier
           /// eg. from arith.add to arith.add(number)
           return temp.replace(temp.find('.'), 1, "_", 1)  + to_string(Operator_Count["arith.add"]);
       }else if(!inputLiteral.compare("memref.alloc")){
           ///Change node variable name as an identifier
           /// eg. from memref.alloc to memref.alloc(number)
           return temp.replace(temp.find('.'), 1, "_", 1)  + to_string(Operator_Count["memref.alloc"]);
       }else if(!inputLiteral.compare("arith.constant")){
           ///Change node variable name as an identifier
           /// eg. from arith.constant to arith.constant(number)
           return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.constant"]);
       }else if(!inputLiteral.compare("affine.store")){
           /// Change node variable name as an identifier
           /// eg. from affine.store to affine.store(number)
           return temp.replace(temp.find('.'), 1, "_", 1)  + to_string(Operator_Count["affine.store"]);
       }else if(!inputLiteral.compare("affine.load")){
           /// Change node variable name as an identifier
           /// eg. from affine.load to affine.load(number)
           return temp.replace(temp.find('.'), 1, "_", 1)  + to_string(Operator_Count["affine.load"]);
       }else if(!inputLiteral.compare("memref.copy")){
           /// Change node variable name as an identifier
           /// eg. from memref.copy to memref.copy(number)
           return temp.replace(temp.find('.'), 1, "_", 1)  + to_string(Operator_Count["memref.copy"]);
       }else if(!inputLiteral.compare("memref.dealloc")){
           /// Change node variable name as an identifier
           /// eg. from memref.deallocc to memref.dealloc(number)
           return temp.replace(temp.find('.'), 1, "_", 1)  + to_string(Operator_Count["memref.dealloc"]);
       }else if(!inputLiteral.compare("arith.mulf")){
           /// Change node variable name as an identifier
           /// eg. from arith.mulf to arith.mulf(number)
           return temp.replace(temp.find('.'), 1, "_", 1)  + to_string(Operator_Count["arith.mulf"]);
       }else if(!inputLiteral.compare("func.func")){
           /// Change node variable name as an identifier
           /// eg. from func.func to Start
           return "Start_Function";
       }else if(!inputLiteral.compare("END")){
           /// Change node variable name as an identifier
           /// eg. from func.func to Start
           return "END";
       }else{
           return"error";
       }
    }

    const string &getSingleNode() const {
        return singleNode;
    }
};


/// Define a MyStack Class inherits from base stack class
class MyStack : public stack<Node> {
public:
    // User-defined stack traverse method
    void traverse() {
        auto c = this->c;
        for (const auto& item : c) {
            cout<<"For node is \t"<<item.getSingleNode()<<endl;
        }
    }
};

int main() {
    //Open source file under Correct Location
    FILE *file = fopen("./matrix_mulitiplication_affine_2.2.mlir", "r");
    if (file == nullptr) {
        printf("File Open failed\n");
        return 1;
    }

    const int bufferSize = 256;
    /// Create the buffer
    char buffer[bufferSize];
    /// Create a list of node variable
    vector<Node> nodeList;
    /// Create a list of edge variable
    vector<Edge> edgeList;
    MyStack forNodeStack;

    while (fgets(buffer, bufferSize, file) != nullptr) {
        string str(buffer);
        /// Find method returns the position of the first occurrence of the substring,
        /// And if the substring is not found, it returns std::string::npos.
        if(str.find("func.func") != string::npos) {
            /// Match the func.func identifier
            /// Append new node in the nodeList
            nodeList.push_back(Node("func.func"));

        }
        else if(str.find("arith.constant") != string::npos){
            /// Match the arith.constant identifier
            /// Append new node in the nodeList
            Operator_Count["arith.constant"]++;
            nodeList.push_back(Node("arith.constant"));

            /// Create the corresponding edge
            if(edgeList.empty()){
/// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));
            }else{
            /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));
            }

        }
        else if(str.find("memref.alloc") != string::npos){
            /// Match the memref.alloc identifier
            /// Append new node in the nodeList
            Operator_Count["memref.alloc"]++;
            nodeList.push_back(Node("memref.alloc"));
            /// Create the corresponding edge
            if(edgeList.empty()){
            /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));
            }else{
            /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));
            }
        }
        else if(str.find("affine.for") != string::npos){
            /// Match the affine.foridentifier
            /// Append new node in the nodeList
            Operator_Count["affine.for"]++;
            Node forNode=Node("affine.for");
            nodeList.push_back(forNode);
            /// Create the corresponding edge
            if(edgeList.empty()){
            /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));
            /// Push the new for node to Stack according to FILO policy
                forNodeStack.push(forNode);
            }else{
            /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));
                /// Push the new for node to Stack according to FILO policy
                forNodeStack.push(forNode);
/*
#ifdef DEBUG
                forNodeStack.traverse();
#endif
 */
            }
        }
        else if(str.find("affine.store") != string::npos){
            /// Match the affine.store identifier
            /// Append new node in the nodeList
            Operator_Count["affine.store"]++;
            nodeList.push_back(Node("affine.store"));

            /// Create the corresponding edge
            if(edgeList.empty()){
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));

            }else{
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));

            }

        }
        else if(str.find("affine.load") != string::npos){
            /// Match the affine.load identifier
            /// Append new node in the nodeList
            Operator_Count["affine.load"]++;
            nodeList.push_back(Node("affine.load"));
            /// Create the corresponding edge
            if(edgeList.empty()){
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));

            }else{
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));

            }
        }
        else if(str.find("memref.copy") != string::npos){
            /// Match the memref.copy identifier
            /// Append new node in the nodeList
            Operator_Count["memref.copy"]++;

/*            nodeList.push_back(Node("memref.copy"));
#ifdef DEBUG
            for(auto &elemt:nodeList){
                cout<<elemt.getSingleNode()<<endl;
            }
#endif
    */        /// Create the corresponding edge
            if(edgeList.empty()){
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));

            }else{
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));

            }
        }
        else if(str.find("memref.dealloc") != string::npos){
            /// Match the memref.dealloc identifier
            /// Append new node in the nodeList
            Operator_Count["memref.dealloc"]++;
            nodeList.push_back(Node("memref.dealloc"));

            /// Create the corresponding edge
            if(edgeList.empty()){
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));

            }else{
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));

            }
        }
        else if(str.find("arith.mulf") != string::npos){
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.mulf"]++;
            nodeList.push_back(Node("arith.mulf"));
            /// Create the corresponding edge
            if(edgeList.empty()){
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));
            }else{
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));
            }
        }
        else if(str.find("arith.addf") != string::npos){
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.addf"]++;
            nodeList.push_back(Node("arith.addf"));
            /// Create the corresponding edge
            if(edgeList.empty()){
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(),nodeList[1].getSingleNode()));
/*
#ifdef DEBUG
                for(const Edge &elem:edgeList){
                    cout<<elem.getEdge()<<endl;
                }
#endif
 */
            }else{
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));

            }
        }
        else if(str.find("return")!= string::npos){
            nodeList.push_back(Node("END"));
            edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),nodeList[nodeList.size()-1].getSingleNode()));
/*
#ifdef DEBUG
            for(const Edge &elem:edgeList){
                cout<<elem.getEdge()<<endl;
            }
#endif
 */
            fclose(file);  // 关闭文件
        }
        else if(str.find('}')!= string::npos && str.find('{')== string::npos)  {

            /// Pop out previous restored `for` node from MyStack;
            /// Create the back edge
            edgeList.push_back(Edge(edgeList[edgeList.size()-1].getSinkNode(),forNodeStack.top().getSingleNode(),true));
            forNodeStack.pop();
        }
    }

    ///Open source file under Correct Location
    ofstream graphFile("../graph.dot");

    if (graphFile.is_open()) { // 检查文件是否成功打开

        graphFile <<"digraph GEMM{"<<"\n";
        for (const auto& node : nodeList) {
            graphFile << node.getSingleNode() << "\n";  // 调用Node类的toString方法，写入文件
        }

        for (const auto& edge : edgeList) {
            graphFile << edge.getEdge() << "\n";  // 调用Edge类的toString方法，写入文件
        }
        graphFile <<"}"<<"\n";
        graphFile.close();  // 关闭文件
    }



    return 0;
}
