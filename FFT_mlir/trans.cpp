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
    {"arith.divsi",0}
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
        else if (!inputLiteral.compare("arith.addf"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.add更改为arith.add(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.addf"]);
        }
        else if (!inputLiteral.compare("memref.alloc"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从memref.alloc更改为memref.alloc(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["memref.alloc"]);
        }
        else if (!inputLiteral.compare("arith.constant"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.constant更改为arith.constant(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.constant"]);
        }
        else if (!inputLiteral.compare("affine.store"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从affine.store更改为affine.store(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["affine.store"]);
        }
        else if (!inputLiteral.compare("affine.load"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从affine.load更改为affine.load(number)
            return temp.replace(temp.find('.'), 1,
                                "_", 1) +
                   to_string(Operator_Count["affine.load"]);
        }
        else if (!inputLiteral.compare("memref.copy"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从memref.copy更改为memref.copy(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["memref.copy"]);
        }
        else if (!inputLiteral.compare("memref.dealloc"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从memref.dealloc更改为memref.dealloc(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["memref.dealloc"]);
        }
        else if (!inputLiteral.compare("arith.mulf"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.mulf"]);
        }
        else if (!inputLiteral.compare("arith.subf"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.subf"]);
        }
        else if (!inputLiteral.compare("arith.addi"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.add更改为arith.add(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.addi"]);
        }
        else if (!inputLiteral.compare("arith.muli"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.muli"]);
        }
        else if (!inputLiteral.compare("arith.subi"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.subi"]);
        }
        else if (!inputLiteral.compare("arith.index_cast"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.index_cast"]);
        }
        else if (!inputLiteral.compare("memref.cast"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["memref.cast"]);
        }
        else if (!inputLiteral.compare("affine.yield"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["affine.yield"]);
        }

        else if (!inputLiteral.compare("scf.while"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["scf.while"]);
        }
        else if (!inputLiteral.compare("do.node"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["do.node"]);
        }        
        else if (!inputLiteral.compare("arith.cmpi"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.cmpi"]);
        }

        else if (!inputLiteral.compare("scf.condition"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["scf.condition"]);
        }

        else if (!inputLiteral.compare("undef.acos"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["undef.acos"]);
        }

        else if (!inputLiteral.compare("arith.sitofp"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.sitofp"]);
        }
        else if (!inputLiteral.compare("arith.divsi"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.mulf更改为arith.mulf(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.divsi"]);
        }

        else if (!inputLiteral.compare("arith.divf"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从arith.add更改为arith.add(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.divf"]);
        }

        else if (!inputLiteral.compare("math.cos"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从memref.alloc更改为memref.alloc(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["math.cos"]);
        }
        else if (!inputLiteral.compare("math.sin"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从memref.alloc更改为memref.alloc(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["math.sin"]);
        }
        else if (!inputLiteral.compare("arith.shrsi"))
        {
            /// 将节点变量名更改为标识符
            /// 例如，从memref.alloc更改为memref.alloc(number)
            return temp.replace(temp.find('.'), 1, "_", 1) + to_string(Operator_Count["arith.shrsi"]);
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
        else
        {
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

        else if (str.find("arith.constant") != string::npos)
        {
            /// Match the arith.constant identifier
            /// Append new node in the nodeList
            Operator_Count["arith.constant"]++;
            nodeList.push_back(Node("arith.constant"));

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

        else if (str.find("memref.alloc") != string::npos)
        {
            /// Match the memref.alloc identifier
            /// Append new node in the nodeList
            Operator_Count["memref.alloc"]++;
            nodeList.push_back(Node("memref.alloc"));
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

        else if (str.find("affine.for") != string::npos)
        {
            /// Match the affine.foridentifier
            /// Append new node in the nodeList
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
                /*
                #ifdef DEBUG
                                forNodeStack.traverse();
                #endif
                 */
            }
        }

        else if (str.find("affine.store") != string::npos)
        {
            /// Match the affine.store identifier
            /// Append new node in the nodeList
            Operator_Count["affine.store"]++;
            nodeList.push_back(Node("affine.store"));

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

        else if (str.find("affine.load") != string::npos)
        {
            /// Match the affine.load identifier
            /// Append new node in the nodeList
            Operator_Count["affine.load"]++;
            nodeList.push_back(Node("affine.load"));
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

        else if (str.find("memref.copy") != string::npos)
        {
            /// Match the memref.copy identifier
            /// Append new node in the nodeList
            Operator_Count["memref.copy"]++;
            nodeList.push_back(Node("memref.copy"));


            /*            nodeList.push_back(Node("memref.copy"));
            #ifdef DEBUG
                        for(auto &elemt:nodeList){
                            cout<<elemt.getSingleNode()<<endl;
                        }
            #endif
                */
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

        else if (str.find("memref.dealloc") != string::npos)
        {
            /// Match the memref.dealloc identifier
            /// Append new node in the nodeList
            Operator_Count["memref.dealloc"]++;
            nodeList.push_back(Node("memref.dealloc"));

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

        else if (str.find("arith.mulf") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.mulf"]++;
            nodeList.push_back(Node("arith.mulf"));
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

        else if (str.find("arith.addf") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.addf"]++;
            nodeList.push_back(Node("arith.addf"));
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

        else if (str.find("arith.subf") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.subf"]++;
            nodeList.push_back(Node("arith.subf"));
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



        else if (str.find("arith.muli") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.muli"]++;
            nodeList.push_back(Node("arith.muli"));
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

        else if (str.find("arith.addi") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.addi"]++;
            nodeList.push_back(Node("arith.addi"));
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

        else if (str.find("arith.subi") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.subi"]++;
            nodeList.push_back(Node("arith.subi"));
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

        else if (str.find("arith.index_cast") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.index_cast"]++;
            nodeList.push_back(Node("arith.index_cast"));
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

        else if (str.find("memref.cast") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["memref.cast"]++;
            nodeList.push_back(Node("memref.cast"));
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

        else if (str.find("affine.yield") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["affine.yield"]++;
            nodeList.push_back(Node("affine.yield"));
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

        else if (str.find("arith.cmpi") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.cmpi"]++;
            nodeList.push_back(Node("arith.cmpi"));
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

        else if (str.find("arith.sitofp") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.sitofp"]++;
            nodeList.push_back(Node("arith.sitofp"));
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


        else if (str.find("arith.divf") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.divf"]++;
            nodeList.push_back(Node("arith.divf"));
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

        else if (str.find("math.cos") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["math.cos"]++;
            nodeList.push_back(Node("math.cos"));
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
        else if (str.find("math.sin") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["math.sin"]++;
            nodeList.push_back(Node("math.sin"));
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

        else if (str.find("arith.shrsi") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.shrsi"]++;
            nodeList.push_back(Node("arith.shrsi"));
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
            string func_name=str.substr(str.find("func.call")+10,5);
            fseek(file, 0, SEEK_SET);
            while (fgets(buffer, bufferSize, file) != nullptr)
            {
                string str1(buffer);
                if(str1.find(func_name)!=string::npos & str1.find("{")!=string::npos){
                    break;
                }
            }
            in_func=1;
        }

         else if (str.find("scf.while") != string::npos)
        {
            /// Match the affine.foridentifier
            /// Append new node in the nodeList
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
                /*
                #ifdef DEBUG
                                forNodeStack.traverse();
                #endif
                 */
            }
        }



        else if (str.find("return") != string::npos)
        {
            if(in_func==0){
                nodeList.push_back(Node("END"));
                edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), nodeList[nodeList.size() - 1].getSingleNode()));
                fclose(file); // 关闭文件
                break;
            }
            else{
                fseek(file, 0, SEEK_SET);
                for(int i=0;i<count;i++){
                    fgets(buffer, bufferSize, file);
                }
                in_func=0;
            }
        }

        else if (str.find("arith.divsi") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["arith.divsi"]++;
            nodeList.push_back(Node("arith.divsi"));
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

        else if (str.find("do") != string::npos)
        {
            /// Match the arith.mulf identifier
            /// Append new node in the nodeList
            Operator_Count["do.node"]++;
            nodeList.push_back(Node("do.node"));
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
        else if (str.find('}') != string::npos && str.find('{') == string::npos)
        {

            /// Pop out previous restored `for` node from MyStack;
            /// Create the back edge
            edgeList.push_back(Edge(edgeList[edgeList.size() - 1].getSinkNode(), forNodeStack.top().getSingleNode(), true));
            forNodeStack.pop();
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
