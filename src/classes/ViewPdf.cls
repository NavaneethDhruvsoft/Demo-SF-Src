public class ViewPdf {
    public Attachment att {
        get {
            if (att == null) {
                att = [SELECT Body, ContentType, Name FROM Attachment WHERE ID = '00P28000005RKV3'];
            }
            return att;
        }
        private set;
    }
    public String pdf {
        get {
            return EncodingUtil.Base64Encode(att.body);
        }
    }
}