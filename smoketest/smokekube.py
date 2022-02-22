from http.client import HTTPConnection
from kubernetes import client, config
from kubernetes.stream import portforward
from kubernetes.stream.ws_client import PortForward

class ForwardedKubernetesHTTPConnection(HTTPConnection):

    def __init__(self, forwarding: PortForward, port: int):
        super().__init__("127.0.0.1", port)
        self.sock = forwarding.socket(port)

    def connect(self) -> None:
        pass

    def close(self) -> None:
        pass

if __name__ == "__main__":
    config.load_kube_config("../terraform-unity/kubeconfig.yaml")
    client_v1 = client.CoreV1Api()
    print("Listing pods with their IPs:")
    ret = client_v1.list_pod_for_all_namespaces(watch=False)
    foundpod = None
    for i in ret.items:
        print("%s\t%s\t%s" % (i.status.pod_ip, i.metadata.namespace, i.metadata.name))
        if(i.metadata.name.startswith("mozart")):
            foundpod = i.metadata.name
    name_space = "default"
    pod_name = foundpod
    port = 8888

    pf = portforward(
        client_v1.connect_get_namespaced_pod_portforward,
        pod_name,
        name_space,
        ports=str(port)
    )

    conn = ForwardedKubernetesHTTPConnection(pf, port)
    conn.request("GET", "/api/v0.1/doc/")
    resp = conn.getresponse()
    print(resp.status)
    print(resp.headers)
    print(resp.read())

