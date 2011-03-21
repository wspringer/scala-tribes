package org.scala.tribes;

import java.io.File;
import java.io.IOException;
import org.kohsuke.args4j.Argument;
import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.Option;

import static com.google.common.base.Preconditions.checkNotNull;
import nl.flotsam.greader.ReaderTemplate;
import nu.xom.Builder;
import nu.xom.Document;
import nu.xom.Node;
import nu.xom.Nodes;
import nu.xom.ParsingException;

public class GreaderUpdater {

    public GreaderUpdater(String email, String password, File file) {
        this();
        checkNotNull(email);
        checkNotNull(password);
        checkNotNull(file);
        this.email = email;
        this.password = password;
        this.file = file;
    }

    private GreaderUpdater() {
    }

    @Option(name = "-e", usage = "The email address of the user.", required = true)
    private String email;

    @Option(name = "-p", usage = "The password of the user.", required = true)
    private String password;

    @Argument(metaVar = "FILE", usage = "The file containing the URLs to be uploaded.", required = true)
    private File file;

    public static final void main(String... args) throws IOException, ParsingException {
        GreaderUpdater updater = new GreaderUpdater();
        CmdLineParser parser = new CmdLineParser(updater);
        try {
            parser.parseArgument(args);
            updater.execute();
        } catch (CmdLineException e) {
            System.err.println(e.getMessage());
            parser.printUsage(System.err);
            System.err.println();
            System.exit(1);
        }
    }

    public void execute() throws IOException, ParsingException {
        ReaderTemplate template = new ReaderTemplate(email, password);
        Document document = new Builder().build(file);
        String token = template.getToken();
        Nodes nodes = document.query("//feeds/news/text()");
        for (int i = nodes.size() - 1; i >=0; i--) {
            Node node = nodes.get(i);
            System.err.println("Subscribing " + node.getValue());
            template.subscribe(node.getValue(), token);
            template.tag(node.getValue(), "scala-tribes", token);
        }
    }

}
