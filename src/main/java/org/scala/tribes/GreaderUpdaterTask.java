package org.scala.tribes;

import java.io.File;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;

public class GreaderUpdaterTask extends Task {

    private String email;
    private String password;
    private File file;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }

    @Override
    public void execute() throws BuildException {
        GreaderUpdater updater = new GreaderUpdater(email, password, file);
        try {
            updater.execute();
        } catch (Exception e) {
            throw new BuildException(e);
        }
    }
}
