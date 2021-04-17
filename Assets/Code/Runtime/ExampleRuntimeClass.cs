
namespace Code.Runtime {
    public class ExampleRuntimeClass {
        void stuff() {
            UnityEngine.Random.Range(5, 5);
            new System.Random(5);
            UnityEngine.JsonUtility.FromJson<int>("");
            // Newtonsoft.Json.
        }
    }
}
