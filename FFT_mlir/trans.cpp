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

using namespace std;
#define DEBUG
/// Record the count of each operator appearance
map<string, int> Operator_Count = {
    {"arith.constant", 0},
    {"memref.alloc", 0},
    {"affine.for", 0},
    {"affine.store", 0},
    {"affine.load", 0},
    {"memref.copy", 0},
    {"memref.dealloc", 0},
    {"affine.load", 0},
    {"arith.mulf", 0},
    {"arith.addf", 0},
    {"arith.subf",0},
    {"scf.while",0},
    {"arith.index_cast",0},
    {"memref.cast",0},
    {"affine.yield",0},
    {"scf.while",0},
    {"scf.condition",0},
    {"arith.cmpi",0},
    {"do.node",0},
    {"undef.acos",0},
    {"arith.sitofp",0},
    {"arith.divf",0},
    {"math.cos",0},
    {"math.sin",0},
    {"arith.shrsi",0},
    {"arith.divsi",0},
    {"arith.muli",0},
    {"arith.addi",0},
    {"arith_subi",0},
    {"llvm.ptrtoint",0},
    {"polygeist.memref2pointer",0}
};

//===--------------------------------------------------------------------===//
// Dot Edge Class
// Define Two variable represent as SourceNode and SinkNode: sourceNode -> sinknode
// eg:inner_affine_loop1 -> inner_affine_loop2
//===--------------------------------------------------------------------===//
class Edge
{

    const string sourceNode;
    const string sinkNode;
    string edge;

public:
    /// Edge class constructor
    Edge(const string &sourceNode, const string &sinkNode) : sourceNode(sourceNode), sinkNode(sinkNode)
    {
        edge = createEdge();
    }

    Edge(const string &sourceNode, const string &sinkNode, bool flag) : sourceNode(sourceNode), sinkNode(sinkNode)
    {

        edge = createBackEdge();

    }
    /// Insert additional operator
    string createEdge()
    {
        return sourceNode + " -> " + sinkNode + ";";
    }
    /// Another member function with regard to Traverse Back Edge
    string createBackEdge()
    {
        return sourceNode + " -> " + sinkNode + " [label=\"back\"];";
    }

    /// Getter function
    const string &getEdge() const
    {
        return edge;
    }

    const string &getSourceNode() const
    {
        return sourceNode;
    }

    const string &getSinkNode() const
    {
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
class Node
{
    const string inputLiteral;
    string singleNode;

public:
    /// Node类的构造函数
    explicit Node(const string &inputLiteral) : inputLiteral(inputLiteral)
    {
        singleNode = addNode();
    }

    /// 这个实用函数执行字符串运算符字符串变换的集合
    string addNode()
    {
        string temp;
        temp = inputLiteral;
        if (!inputLiteral.compare("affine.for"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从affine.for更改为affine_for_loop_str(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + "_loop" + to_string(Operator_Count["affine.for"]);
        }
        
        else if (!inputLiteral.compare("undef.acos"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["undef.acos"]);
        }
        else if (!inputLiteral.compare("func.func"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从func.func更改为Start_Function
            return "Start_Function";
        }
        else if (!inputLiteral.compare("END"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从func.func更改为END
            return "END";
        }
        else{
            for(auto it:Operator_Count){
                if(!inputLiteral.compare(it.first)){
                    return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count[it.first]);
                }
            }
            return "error";        
        }
    }

    const string &getSingleNode() const {
        return singleNode;
    }
};

/// Define a MyStack Class inherits from base stack class
class MyStack : public stack<Node>
{
public:
    // User-defined stack traverse method
    void traverse()
    {
        auto c = this->c;
        for (const auto &item : c)
        {
            cout << "For node is \t" << item.getSingleNode() << endl;
        }
    }
};

int main()
{
    // Open source file under Correct Location
    FILE *file = fopen("./test2.mlir", "r");
    if (file == nullptr)
    {
        printf("File Open failed\n");
        return 1;
    }
    bool in_func=0;
    int count=0;
    const int bufferSize = 256;
    /// Create the buffer
    char buffer[bufferSize];
    /// Create a list of node variable
    vector<Node> nodeList;
    /// Create a list of edge variable
    vector<Edge> edgeList;
    MyStack forNodeStack;

    while (fgets(buffer, bufferSize, file) != nullptr)
    {
        if(!in_func){
            count++;
        }
        string str(buffer);
        /// Find method returns the position of the first occurrence of the substring,
        /// And if the substring is not found, it returns std::string::npos.0
        
        if (str.find("func.func") != string::npos)
        {
            /// Match the func.func identifier
            /// Append new node in the nodeList
            nodeList.push_back(Node("func.func"));
        }

        else if (str.find("affine.for") != string::npos)
        {
            Operator_Count["affine.for"]++;
            Node forNode = Node("affine.for");
            nodeList.push_back(forNode);
            /// Create the corresponding edge
            if (edgeList.empty())
            {
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(), nodeList[1].getSingleNode()));
                /// Push the new for node to Stack according to FILO policy
                forNodeStack.push(forNode);
            }
            else
            {
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
                /// Push the new for node to Stack according to FILO policy
                forNodeStack.push(forNode);
            }
        }

        else if (str.find("call @acos") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["undef.acos"]++;
            nodeList.push_back(Node("undef.acos"));
            /// Create the corresponding edge
            if (edgeList.empty())
            {
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(), nodeList[1].getSingleNode()));

            }
            else
            {
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
            }
        }

        else if (str.find("func.call") != string::npos)
        {
            string func_name=str.substr(str.find("func.call")+10,5);//截取函数名
            fseek(file, 0, SEEK_SET);   //将文件读取位置设置到文件开头
            while (fgets(buffer, bufferSize, file) != nullptr)
            {
                string str1(buffer);
                if(str1.find(func_name)!=string::npos & str1.find("{")!=string::npos){  //寻找函数主题，通过同时找到函数名和"{"判断
                    break;
                }
            }
            in_func=1;      //将函数标志位置1
        }

         else if (str.find("scf.while") != string::npos)//while当做for来处理
        {
            Operator_Count["scf.while"]++;
            Node forNode = Node("scf.while");
            nodeList.push_back(forNode);
            /// Create the corresponding edge
            if (edgeList.empty())
            {
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(), nodeList[1].getSingleNode()));
                /// Push the new for node to Stack according to FILO policy
                forNodeStack.push(forNode);
            }
            else
            {
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
                /// Push the new for node to Stack according to FILO policy
                forNodeStack.push(forNode);
            }
        }

        else if (str.find("return") != string::npos)
        {
            if(in_func==0){     //不在调用函数的过程中中则结束
                nodeList.push_back(Node("END"));
                edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
                fclose(file); // 关闭文件
                break;
            }
            else{           //在调用函数的过程中
                fseek(file, 0, SEEK_SET);//设置文件读取头到文件头
                for(int i=0;i<count;i++){//根据之前记录的位置将文件读取位置设置过去
                    fgets(buffer, bufferSize, file);
                }
                in_func=0;  //将函数标志位置零
            }
        }
        else if (str.find("do") != string::npos)
        {
            Operator_Count["do.node"]++;
            nodeList.push_back(Node("do.node"));
            if (edgeList.empty())
            {
                edgeList.push_back(Edge(nodeList[0].getSingleNode(), nodeList[1].getSingleNode()));
            }
            else
            {
                edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
            }
        }
        else if (str.find('}') != string::npos && str.find('{') == string::npos)//剔除do的情况
        {
            edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), forNodeStack.top().getSingleNode(), true));
            forNodeStack.pop();
        }

        else if (str.find("call @acos") != string::npos)
        {
            Operator_Count["undef.acos"]++;
            nodeList.push_back(Node("undef.acos"));
            if (edgeList.empty())
            {
                /// Initialization of edgeList
                edgeList.push_back(Edge(nodeList[0].getSingleNode(), nodeList[1].getSingleNode()));

            }
            else
            {
                /// Create the subsequent edges
                edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
            }
        }        
        else{
            for(auto it:Operator_Count){
            if(str.find(it.first)!=string::npos){
                Operator_Count[it.first]++;
                nodeList.push_back(Node(it.first));
                // Create the corresponding edge
                if (edgeList.empty())
                {
                /// Initialization of edgeList
                    edgeList.push_back(Edge(nodeList[0].getSingleNode(), nodeList[1].getSingleNode()));
                }
                else
                {
                /// Create the subsequent edges
                    edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
                }
                break;
            }
        }          
        }      
    }

    /// Open source file under Correct Location
    ofstream graphFile("./graph_test2.dot");

    if (graphFile.is_open())
    { // 检查文件是否成功打开

        graphFile << "digraph FFT{"
                  << "\n";
        for (const auto &node : nodeList)
        {
            graphFile << node.getSingleNode() << "\n"; // 调用Node类的toString方法，写入文件
        }

        for (const auto &edge : edgeList)
        {
            graphFile << edge.getEdge() << "\n"; // 调用Edge类的toString方法，写入文件
        }
        graphFile << "}"
                  << "\n";
        graphFile.close(); // 关闭文件
    }

    return 0;
}
