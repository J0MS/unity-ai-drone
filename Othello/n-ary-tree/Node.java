/* ===== ===== =====

IA/Othello
- N-ary tree data structure

===== ===== ===== */

import java.util.ArrayList;

public class Node {
    final String LABEL;
    final int N;
    private final ArrayList<Node> children;

    public Node(String LABEL, int n) {
        this.LABEL = LABEL;
        this.N = n;
        children = new ArrayList<>(n);
    }

    private boolean addChild(Node node) {
        if (children.size() < N) {
            return children.add(node);
        }
        return false;
    }


    public boolean addChild(String label) {
        return addChild(new Node(label, N));
    }

    public ArrayList<Node> getChildren() {
        return new ArrayList<>(children);
    }

    public Node getChild(int index) {
        if (index < children.size()) {
            return children.get(index);
        }
        return null;
    }

    public static void print(Node root) {
        printUtil(root, 0);
    }


    private static void printUtil(Node node, int depth) {
        for (int i = 0; i < depth; ++i) {
            System.out.print("   ");
        }
        System.out.println(node.LABEL);
        for (Node child : node.getChildren()) {
            printUtil(child, depth + 1);
        }
    }
}

class TestNaryTree {
    public static void main(String[] args) {
        int n = 3;
        Node root = new Node("Son1", n);
        root.addChild("grandchild1");
            root.getChild(0).addChild("gc1");
                root.getChild(0).getChild(0).addChild("3");
                root.getChild(0).getChild(0).addChild("4");
                root.getChild(0).getChild(0).addChild("5");
            root.getChild(0).addChild("gc2");
                root.getChild(0).getChild(1).addChild("6");
                root.getChild(0).getChild(1).addChild("7");
                root.getChild(0).getChild(1).addChild("8");
                root.getChild(0).getChild(1).addChild("9");  // won't add
        root.addChild("Son2");
            root.getChild(1).addChild("Grandchild2");
                root.getChild(1).getChild(0).addChild("1");
                root.getChild(1).getChild(0).addChild("2");
            root.getChild(1).addChild("gc4");
                root.getChild(1).getChild(1).addChild("4");
                root.getChild(1).getChild(1).addChild("5");
        Node.print(root);
    }
}
